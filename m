Return-Path: <linux-kernel+bounces-172903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6898BF85D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3129B20EFF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C44085E;
	Wed,  8 May 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Rsfkx9LY"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD72C861
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156489; cv=none; b=frGW8+JxlnNaxpWdKhnlkRomUWayUTCxZX6DYXiyBSjJqTooNEliIP5nKyMCTGIEUfnRGX3H9Qip8V+ZH3BcZRwVGJFgC0llZCYmBNRu9bsz+WnvrBuQQrgINs2Ja0HYhakflncU639qfFFWNdBdQmvxZKOiLy8gSG40s41Rsdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156489; c=relaxed/simple;
	bh=HL7En7OBTcPuMbQQapaF7sp8ONja5eBac9REyP9vuAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI68HfmcTcctaKIu4r+oEZ0zDQz7lmiHL9GTxXpnA2HYXubFtVXzBrPGqH6BR58YpfHdajWw9qTOUJYuyZUmB8fn0ImswikRY79xdIAAWgoQmBveDrTM67ZC2R0grVG8bUQZ6ITPzjdGALQ5/bv13z+RQbnEu1BhtHivQllA0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Rsfkx9LY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a64db066so1036249566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715156486; x=1715761286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ixA6ZpFhbriwN643+FDPmx+8B3vSAEW3xMrMho4mmU=;
        b=Rsfkx9LYtrTVtrmzCEStY9k34OZFYmQfzWN8bDhMq5PH2SyXPKkVxKhKfZArDGVyna
         al/fwPeQqBRvmDVtZ/mBI4gFyeoJTWMdKJ0p9OFY2iKMAcPxYEVVV42NQlSzQKRNxO35
         dyugODuQnoWWgBhZn84RjeCxi+8ztcSw00WdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715156486; x=1715761286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ixA6ZpFhbriwN643+FDPmx+8B3vSAEW3xMrMho4mmU=;
        b=mdhWfbcJeDaXnDn8w3Icu0RpggO45pesJLOYaYFzGk1BfEpUUWzkpgmqrqBX2vDiaR
         eO2LIFALoE0Ez+bQo/VcsZr2+Tgq9iNJodrzkGn3XhVbjAsGwS7KeX7W17O5NLc/ayWG
         v1Lbw6g+mp/ha4Pu/7GXyS7k6q7BalTVqiwRTlSmuMGgD6M61YYO3PHGWFlCn3V9IGWW
         Zh1nieAPQ8swEUBKVWsEUi6eKCCOkkBZpvmPeyRAh1uPBsxwA/Wv8HPC8S2kKj7iGEVT
         RuOhSVzEESN0rDVaIxHxn5d0PWP0ocKfUhAa3gO1TfESyS7mBHg4HN6E48kBFPWswHN1
         8Ktw==
X-Forwarded-Encrypted: i=1; AJvYcCXPujEm9bNfD4rn5dD3HhpYin9CpwHyfOcfZ9foOdGqlnF7XnUQvrKvxlP9rt3H+8C2oseGucemfT4Pz0VpdN2pb1AgPdWZlhT15n4a
X-Gm-Message-State: AOJu0YxEHnamUdcLYZd8h4J8Q+VLuWAtuP2GV6cYBkFtVgrrw8AHRoT0
	X8qF1DWt/kqFY17FRTTImbYLgYe60uzSYzbs5a46wJLDFzWMkmiT5pz7HWi3l4YsmvGF9ouFrjE
	lCGY2TK46i4eZnvzJFY1J9PEzWlJX2JzXmhpmbA==
X-Google-Smtp-Source: AGHT+IEUwgNbxTRR94GvmkXfJy+HcI6FvAeWKvWbx/fHAbKjVPAPYyyg84Vq8bpWAtvA2x+cdeFgAm8Ossyl3nHARjc=
X-Received: by 2002:a17:906:f298:b0:a52:2486:299f with SMTP id
 a640c23a62f3a-a59fb9e9959mr112631066b.71.1715156486167; Wed, 08 May 2024
 01:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLwAe+hVUNe+bsYeKJJQ-G9svs7dR2ymZDh0PsfqFNMm2A@mail.gmail.com>
 <2625b40f-b6c5-2359-33fe-5c81e9a925a9@huaweicloud.com>
In-Reply-To: <2625b40f-b6c5-2359-33fe-5c81e9a925a9@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 May 2024 10:21:14 +0200
Message-ID: <CAJfpegvGhtLSxOHUQQ95a3skqEgEPt+MzpBT8vOOdqWcRxPR5Q@mail.gmail.com>
Subject: Re: WARNING in fuse_request_end
To: Hou Tao <houtao@huaweicloud.com>
Cc: lee bruce <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org, 
	yue sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 15:30, Hou Tao <houtao@huaweicloud.com> wrote:

> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3ec8bb5e68ff5..840cefdf24e26 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1814,6 +1814,7 @@ static void fuse_resend(struct fuse_conn *fc)
>
>         list_for_each_entry_safe(req, next, &to_queue, list) {
>                 __set_bit(FR_PENDING, &req->flags);
> +               clear_bit(FR_SENT, &req->flags);
>                 /* mark the request as resend request */
>                 req->in.h.unique |= FUSE_UNIQUE_RESEND;
>         }
>

ACK, fix looks good.

Would you mind resending it as a proper patch?

Thanks,
Miklos

