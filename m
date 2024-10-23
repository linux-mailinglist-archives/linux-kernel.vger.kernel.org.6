Return-Path: <linux-kernel+bounces-378820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823AD9AD5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7FD1F22D65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE231CEE8A;
	Wed, 23 Oct 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUVBfO76"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F83149013
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716485; cv=none; b=r67fX29zDB8Tf2ENxgAsub8LCxt/1+GqEoB4sVCRiPDo/WNBwJYhTZM+q4HkYGfBUHlzTMVv9odsvXQ/Lv4I8L83JlWz77LewwT8kis3xu+FSUhC+dtvJupbhZm2Y+bKEwnXcZjMeZzJb85dMabe2gwg5fttqVTe5L6Wqem/FL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716485; c=relaxed/simple;
	bh=g3yDIQ0Hn7b5HI9LWWgm+c/OXjR2KbQmSpD1XwwaWwg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=dJYbg/vKB4PFeQ9S/w9i8MPHwQRfgFjj2+eFvr5pZAvPTckDjoKLlMjhsG11XPJZxvhxo4E9DSx70TclzX8gvebNv0o8kLrJ+gP1e54Qhn4p2OoecXXUxINPVTP2/85NVRNSq+iYVVJRu5YOOVILCdtxPT7o7ww6uLePy21B0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUVBfO76; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43163667f0eso1953515e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729716482; x=1730321282; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3yDIQ0Hn7b5HI9LWWgm+c/OXjR2KbQmSpD1XwwaWwg=;
        b=FUVBfO76Mb5OOEVch0kSJ9m1z2LccRpeghF9mgaWe9Io9JRMmvmusRBrHirk2awBir
         kgqjHdn4hSu6iTvz8ZMr+bEktE2WxcS3wCe248mtG4MmAjfAT8rsJgiAHALRODmCuR3n
         lXBV90FMhW/LF51pjPisyUvH91P098XpnNKrsKLF+4NAa3NI/VDUs3beRvu6o5cHwtL0
         Cvr0xc23rNf4erLYWu3IvLWEdd6eZw8V76zEmTuewh54bB3rC9WyRLAaq8c/8dNArcMW
         xt0U337njEGWdUd6kBzlnJJ10nF5WU1Mhz8/Th2gXpwyaUepcWjYqmqyjtkStINLWW4F
         15Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716482; x=1730321282;
        h=in-reply-to:content-language:from:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g3yDIQ0Hn7b5HI9LWWgm+c/OXjR2KbQmSpD1XwwaWwg=;
        b=t2bUp63F/9YyQFg+nwHSdWZv/QUt6zvUMt40eBFF+uoimhvugMMU3pZJpkuUB9eU5l
         gDRsk8+nclfeKtuXssSZNkVJDmnIl/Ti9fcmz/dtrK6/v+M1JuklY38EhaYZ4yXma477
         UTUyycI079QUmip+f4+zYJydbAQ6b+pfG3L4TwDGIV1psO18QWX0Vy7AmurLmUfAQWFp
         7KbJCcF7torToxP0wiOuRND72Eh751Hyl0Eb1B8dEKUq7m9YPCrfMcZaXG84Jd8+4smV
         TgJEZ4aAwEhPbMQBzXsMJ3b6ew2Shf4NbDQ7jWNU0FUas/8ez+VoxUXF/lv+w6Ymu0UQ
         PHQg==
X-Forwarded-Encrypted: i=1; AJvYcCVJkh5IXsEjwNm8BK+RG71kvrbJr+I3RrIhqjqJCACinaBEapGzMBgUtHgGE9lSCUWc93gWI54dqG7qlM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpgBWUDfmB0wRLSdhqiRSb4prFNl/U1ttoO/2/02Z/StQL0ypW
	mpwjKnEdzBNV0IYg5nViHxbyxsAlWeouybCWDvnShCakbxpMAn0h
X-Google-Smtp-Source: AGHT+IEY5BPPW4C1A1toeAOtCeuL9QKUOlZxfhE0qhRtDxtecWDmi1K/plr98TdVGL1RTE8jBmuFSg==
X-Received: by 2002:a05:600c:1d06:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-431841fd955mr29215195e9.11.1729716482000;
        Wed, 23 Oct 2024 13:48:02 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5400:7400:ce29:8129:5435:b143? ([2a01:e11:5400:7400:ce29:8129:5435:b143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c3a5b4sm26329015e9.38.2024.10.23.13.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 13:48:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------br9AxmBhP400fWy64ywOM9Hr"
Message-ID: <05c21638-620e-44e6-a08a-c4166304b660@gmail.com>
Date: Wed, 23 Oct 2024 22:47:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in
 validate_sb_layout
To: syzbot <syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <671955c2.050a0220.1e4b4d.0095.GAE@google.com>
From: Gianfranco Trad <gianf.trad@gmail.com>
Content-Language: en-US, it
In-Reply-To: <671955c2.050a0220.1e4b4d.0095.GAE@google.com>

This is a multi-part message in MIME format.
--------------br9AxmBhP400fWy64ywOM9Hr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test
--------------br9AxmBhP400fWy64ywOM9Hr
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-bcachefs-Fix-invalid-shift-in-validate_sb_layout.patch"
Content-Disposition: attachment;
 filename*0="0001-bcachefs-Fix-invalid-shift-in-validate_sb_layout.patch"
Content-Transfer-Encoding: base64

RnJvbSAwNzFjNGE2MzExYTFmZjUzZWM2MDk3ZWJjYTQ1NjFkMTg4MDI3MWMzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBHaWFuZnJhbmNvIFRyYWQgPGdpYW5mLnRyYWRAZ21h
aWwuY29tPgpEYXRlOiBXZWQsIDIzIE9jdCAyMDI0IDIyOjQyOjU2ICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gYmNhY2hlZnM6IEZpeCBpbnZhbGlkIHNoaWZ0IGluIHZhbGlkYXRlX3NiX2xh
eW91dCgpCgpTaWduZWQtb2ZmLWJ5OiBHaWFuZnJhbmNvIFRyYWQgPGdpYW5mLnRyYWRAZ21h
aWwuY29tPgotLS0KIGZzL2JjYWNoZWZzL3N1cGVyLWlvLmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9i
Y2FjaGVmcy9zdXBlci1pby5jIGIvZnMvYmNhY2hlZnMvc3VwZXItaW8uYwppbmRleCBjZTc0
MTBkNzIwODkuLjQyODE3Mjg5NzUwMSAxMDA2NDQKLS0tIGEvZnMvYmNhY2hlZnMvc3VwZXIt
aW8uYworKysgYi9mcy9iY2FjaGVmcy9zdXBlci1pby5jCkBAIC0yODcsNyArMjg3LDcgQEAg
c3RhdGljIGludCB2YWxpZGF0ZV9zYl9sYXlvdXQoc3RydWN0IGJjaF9zYl9sYXlvdXQgKmxh
eW91dCwgc3RydWN0IHByaW50YnVmICpvdXQKIAkJcmV0dXJuIC1CQ0hfRVJSX2ludmFsaWRf
c2JfbGF5b3V0X25yX3N1cGVyYmxvY2tzOwogCX0KIAotCW1heF9zZWN0b3JzID0gMSA8PCBs
YXlvdXQtPnNiX21heF9zaXplX2JpdHM7CisJbWF4X3NlY3RvcnMgPSAxIDw8ICBtaW4oQkNI
X1NCX0xBWU9VVF9TSVpFX0JJVFNfTUFYLCBsYXlvdXQtPnNiX21heF9zaXplX2JpdHMpOwog
CiAJcHJldl9vZmZzZXQgPSBsZTY0X3RvX2NwdShsYXlvdXQtPnNiX29mZnNldFswXSk7CiAK
LS0gCjIuNDMuMAoK

--------------br9AxmBhP400fWy64ywOM9Hr--

