Return-Path: <linux-kernel+bounces-352656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D77992237
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 01:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C061E2816A8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 23:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D571118B49F;
	Sun,  6 Oct 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfmNzbD9"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F41172777
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728255965; cv=none; b=rS0NeYlRyDrHNV1FjUPnfN9EGxpKSkSvX0SDFEkMlhfnxDXv0R9/y9nZ/x8Lc/9ehgqWrRpRKOe2E9HAe94xf/0gXv7iNT2W3xI9+ZVAruY/2gImacRIc4nnQXmDb2lOAW6g1j+Ft3YYThBWnIVZc8h/4Ynl2b8XeaaGtzKVivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728255965; c=relaxed/simple;
	bh=+QvQynSmccDaog+yB2MZ8h9+nFRsoRQ1kGn41csbUYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiCzUuzY1Qpx71YzAj4btNuCugzzHp4lMUKaY3v7Wuac5ui7jC0or2n3CIN5Mf1iEghIP1NG08qfIXbAIS6PZapaZhiLD/d9WpEqDL1n4cBwXNuVL6Up7YUmP6iCTUjmKftHav2fcZ4EoTnLpcnf+lGWHPMhm+zuAsTNyfI5KLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfmNzbD9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9951fba3b4so82292566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728255958; x=1728860758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5hOq+9nTZcHXUrQtino23eonsn3vwut4AkmDe/WxPg=;
        b=kfmNzbD9dT6B8GT9mFy6yQFvOyY9oShaL54T7KizV0UD6FGVdqMEal8SvsOtcvosao
         MpuH7ttBjfMUUbdAmqnc4LIVDmqC4DG6y5T/cqixX957sHucnYNCj178nRQBcWPDdtzY
         1r0NkdBbibxJneurEmQo78Qk7kuMzeIB9GaMXMpHNKhmvIdC3ejEZ+CL11B8L0SPGHQ2
         MJURWBxWAVwRhj00vNbzRb99sCBPCm3SXl6wxjPsMAIl4kq45MvQgGWR1r7ldAVrlhza
         nLZWs/ezMJkKZD/wGj/VhbDPaNh2vm7FxEp1658cZNxQi+cl6rN5QeB8RT8iRRSZA56v
         LWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728255958; x=1728860758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5hOq+9nTZcHXUrQtino23eonsn3vwut4AkmDe/WxPg=;
        b=qtXNy/GgCHc//f1cHBgsCd1Dj0Wi3wHddtK3gonb9kGQ69lCMXJd3LgCzUAZsqbJNw
         Kyk78MimUvrwKD98etoJMEDm5WDkfGLe4ApD+y3TPSWGbrOARiQWemvjMIlwhVju0rkB
         ENYBiSdR8TOZkOOrlcIbKLQU5dC2sgECu7l+j+kP/4YCJ4tS25hzkkQuBsxQjSf63qry
         A5Loqs7kZ1YUu0kjFa/t0X37UB4lQrzSYqJO357HJRImNS5H1tgyFjUctHwMnjwGT0js
         NM9iDLX78y+HAyRKoNfns8NAFV5wipnLQxNuKIGvVUKQoU7IXf/5CFnFw8NTJcwST4e4
         aN9A==
X-Forwarded-Encrypted: i=1; AJvYcCV5pfP/ERuupymx6n23+GISToyZ5TMPTcf/jLLNkAyjIsFQokfha/vTOHL7QrZ9JsN6RNb4r/tRhOt7w6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywevnl/8VW5nsMW6jSuOcyzK8LinHMiGU9OxJFr/cKDB+koVbdh
	i+5QzwQlrRiVEro2OPCofZAQ4+BW15VCw03R+ykZTklOd7yg6xNBNt8A9au6
X-Google-Smtp-Source: AGHT+IH8MNS68OMs4d+If6kHaYxJ7EE0eKAOPV/FA0Gp5kM3SK3TOZEkbSq7wbPmX01328yhZfVoQA==
X-Received: by 2002:a17:906:7954:b0:a99:58ab:ae0 with SMTP id a640c23a62f3a-a9958ab0da3mr104688866b.30.1728255958048;
        Sun, 06 Oct 2024 16:05:58 -0700 (PDT)
Received: from gmail.com ([45.250.247.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9941a697cesm222822866b.173.2024.10.06.16.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 16:05:57 -0700 (PDT)
Date: Mon, 7 Oct 2024 04:35:50 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
	David Laight <David.Laight@aculab.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] fs/qnx6: Fix building with GCC 15
Message-ID: <2nnud556pfpx5jpn6ib7hre5ompspbiwdcbvn3ia7eosv4bjl5@4aq6ys7wxjkt>
References: <vch6gmzqaeo22c7473qyabrfwxlkdhx5vgvosjyp5l2nwgqnxl@5x3ny35qyfgx>
 <20241004094921.615688-1-brahmajit.xyz@gmail.com>
 <20241004184440.GQ4017910@ZenIV>
 <665bcd89cf5f4679a38e9a84fa0ba42a@AcuMS.aculab.com>
 <20241006200046.GF4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241006200046.GF4017910@ZenIV>

On 06.10.2024 21:00, Al Viro wrote:
> > Indeed - looks like it is checking that the first two directory entries
> > are "." and ".." in about the most complex way possible.
> > 
> > I have vague recollections on some code that ignored the first two entries
> > because they 'must be "." and ".."' - and then failed because some filesystem
> > (and I can't even remember the O/S) didn't meet its expectations!
> > 
> > A simple:
> > 	if (strcmp(dir_entry[0].de_fname, ".") || strcmp(dir_entry[1].de_fname, ".."))
> > 		error = 1;
> > would suffice.
> 
> memcmp(), please.  strcmp() is _not_ guaranteed to be safe without both being
> NUL-terminated; yes, compiler will almost simplify that in case when one of
> the arguments is a string literal, but it's better to do straight memcmp() in
> this case.  It's not worth trying to be fancy there...

Hi Al,
Hi David,

Is my version 2 of the patch correct, I updated with Al's initial
recommendation (both in terms of the patch and commit). Is there
anything else that needs to be updated/added.
-- 
Regards,
listout

