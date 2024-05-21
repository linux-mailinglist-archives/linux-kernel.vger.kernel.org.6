Return-Path: <linux-kernel+bounces-184328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563418CA579
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86B61F22B68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437A5C89;
	Tue, 21 May 2024 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5WVv8gR"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED08441F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253019; cv=none; b=ZBJEIM08iTI/80eSaHYTWZe3K/nx6ohq3gVwkWMowBTCBQUm6mxZBqY+NEZTuQ4q+33hjwRuhMn3bG4D7LU1F8OXeGX6TKRxIHWEAWf/WH1+Z0MozORkL6Fsx4Bkudnu8rd3Bo8+WWRupq4o1eHuc+gQcmo4c7UO4born/x34Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253019; c=relaxed/simple;
	bh=TKeol2dSxBk49iqQ//cAEQqUVFfMbeJOo24PAoZct6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoV7ONlLOc2/tYC0SYfVzbDFYJ/eYaLn+unfYsAu5fCX+DWGKsz2ZJqhWGxqbO/mqZ9QJ/7GPVykJixApo20cd42Dx92jBcIs0u7S8m3ZsCyjCRPn/krqybgSUYM27n8Bj0SBYVL0EjBBaU/xA/b1HUq+EgUzI3WlhCiCLZFfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5WVv8gR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34d7d04808bso2211622f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716253016; x=1716857816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDFjVEIxnzzbbdCDf35cR3KZt93rZh1X8rbzHgZqemI=;
        b=M5WVv8gR8EPeY1gVnLqxUKIdrDJMO1Ln1ndiePc8BzPwJmCgsTyv+7GrIV8iyBpBIW
         luEIHiqWI2KRIrjOBwvfyRfjTwd6BxaNFwFRQGA88ujCJLhqOSXrPyJZim/EVJmxvgv+
         S55QvDND34vx4oR4ZKYoaoqD56HBexE6amszSf9Vk3KCbUwY2Tl7i2Nl2/XcPSIs0w1Z
         T0G2eflyQOFDWVJKvs1cxvtvg2oCFFVzkJyBoV3+2W8WcyEGON4RB2fDtOh31GUe3nSd
         XIaqd29BsxYcE3EH30Lkr6Q4gXwl3KCfdmqh6lW3c01TZjXxexTLWYCD5jbffNPmz5AX
         uFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253016; x=1716857816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDFjVEIxnzzbbdCDf35cR3KZt93rZh1X8rbzHgZqemI=;
        b=ihYvFGhdpSjqozpiYuAg9xv/PsRcCC/iV5i5r4G4z0URsIr1ER/jRmqYpSfexk8tlz
         aYAgHcaQ39Pt0CwerPdzROXzLpqr+iTNDbI46ajti6k34ZoXCmzge/G4axW4tdHYNcG8
         R8GpHWKxSj9KyO3h4ABMChFhTjASJcN4XWP2aJ84EByieGO6neRCzXDhxB0HTJBsWAfN
         c5qEgA68N0bJ/gX+Qos0l8trjIo+j1RBrvR3DqREq1i5v6BbB33MxjCDHh2S9ezrLkSz
         32XyuF3sq+AdtzBJGNPOGC8PdmaYtRs/X/eFbrgJjQlxg1R0N/ZmNfCspl559mn4IxZb
         I7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCU24VQDgOoOw0rYmVxjBV3UyJwjgUFOprVoZ0Ai5MgQHStzv5KYxdrpezVuosZLI0YndYzvZi6gsR9HN2Q8WS6EC7eyPlb3RoDi0JeW
X-Gm-Message-State: AOJu0Yy3XJyblRIf9ArJK0ElVgJqlDfQ5Tjpdg9BUO+ilDNLHUb7wJ9L
	KXvd36Dc9E/EnAuBJMMJXhn0N3+6MEpyt6uZYGpnJ/X9QVDAhYM7bv8DIjy/DMKKjR8jfO9fFcM
	pdzAjkW+2uqdP8EnDXuz66zvQQR8=
X-Google-Smtp-Source: AGHT+IH57y+Tq9h+ZlICLNECCaXrn/08OlecWEWCwOXqN0yA/w+Zu47PAOyA6HJjp6vdSo7wPCQkh2RGLBrCZ4q3F0k=
X-Received: by 2002:adf:e586:0:b0:34f:3293:85c6 with SMTP id
 ffacd0b85a97d-3504a96b7c9mr31557621f8f.64.1716253015538; Mon, 20 May 2024
 17:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com> <Zkup-c2K74bxVJ0i@google.com>
In-Reply-To: <Zkup-c2K74bxVJ0i@google.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 21 May 2024 08:56:44 +0800
Message-ID: <CAHJ8P3J=qJMp=VjB3Ui19AWAf3O3df4bmNwhMo0Rg_Nf+w3Y7w@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix to check return value of f2fs_allocate_new_section
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 3:52=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 05/17, Zhiguo Niu wrote:
> > commit 245930617c9b ("f2fs: fix to handle error paths of {new,change}_c=
urseg()")
> > missed this allocated path, fix it.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >  fs/f2fs/segment.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index a0ce3d0..71dc8042 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -5190,7 +5190,9 @@ static int fix_curseg_write_pointer(struct f2fs_s=
b_info *sbi, int type)
> >       if (cs->next_blkoff) {
> >               unsigned int old_segno =3D cs->segno, old_blkoff =3D cs->=
next_blkoff;
> >
> > -             f2fs_allocate_new_section(sbi, type, true);
> > +             err =3D f2fs_allocate_new_section(sbi, type, true);
> > +             if (err)
> > +                     return err;
>
> I hesitate to apply this, since this may give mount failures forever. Do =
you see
> a real issue with this?
Hi Jaegeuk,
No I did not have a real issue related to this, just found it by code revie=
w.
it is ok not to apply this for me .
thanks a lot.
>
> >               f2fs_notice(sbi, "Assign new section to curseg[%d]: "
> >                               "[0x%x,0x%x] -> [0x%x,0x%x]",
> >                               type, old_segno, old_blkoff,
> > --
> > 1.9.1

