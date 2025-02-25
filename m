Return-Path: <linux-kernel+bounces-532439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E92D2A44DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7660D7AEDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1D1A9B58;
	Tue, 25 Feb 2025 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOqf8PvQ"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5120F096
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515741; cv=none; b=mIj0JCtPdy9HBhvTRuw7ZLSpy28MEBnRSXFl/XVJ5Kz0Js3Ck4bmi9yj26Yw7NDTxT35ZwjEp/oTNIL3WIi4k94k1S4VKnWNO96NOcrZ4k/VRc5z31zfVWsdg5kmduBjiB3fh1wsA9zbZu12efn1o0vpdimx1B6qaVuvYeDrNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515741; c=relaxed/simple;
	bh=5y8DG4ujk6UmFDd045bFEiAUyfoxOhfeUGFPPetLBmQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=io34FY5qmRifqyGwg2s0PwM84eHVdZMMLSpMpbspO7gpl1CdVXIei6x7vPhUvUoVaEqaL7A6uVTDOAz29WlxpEkrnP3/u24FPV1iFYU97UkQFWJTqdbfL0jNLlMKDEtkqpQd6ip6TV58IDOEoVxiCKCMNjMktKFAfJrj7qYFwYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOqf8PvQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so11949873a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740515739; x=1741120539; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X1xzEggswaTEG+QKVHsNuG5EsN89J5nNnjSLHcL01hE=;
        b=AOqf8PvQbeKpH6LmpX9PO+jEcJIOJL5MHy1M/4P3x0xRpAhczQXRv4LdGya5Tf5C0Q
         NGw/jEswIL1gJd7JMtElnSKWKEGBx1yRQlOjRWDfm0GkLTlW9QEORL484uuUuW/vh3Dz
         Wb14NcPqt8ZoglANnezDB2UZq8Y/CIbTGhRoeoAmsxQbX4pAIPjW23FbYqbCBmE1Q/DS
         dYeuLmu+cMCuxNDFmx4wXrdOYuStqw9Kv6KtTNGgziRjQ2YmA9Yfo4e06wZqp0LQ2EMF
         bTGI21GDnVfUnDpxZ7Cd8Wje2/DcJTAt89AlBhOl+zK1v+HixzgBkLNlMhgEzlNgJkm5
         8C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515739; x=1741120539;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1xzEggswaTEG+QKVHsNuG5EsN89J5nNnjSLHcL01hE=;
        b=uKTVDZWK2QtxLVZRi/RvCYEbbkz5+9JqjvcEJHQ9b8Hvyc+j3Z0zxEXlcmY9jtf8wK
         P2GUiWhpXJ/IB9q1vjp+p9yJN1XB8vLoTbtWEmjLDv1VF0rXzjUwrnS0hOHnp5rEEs1j
         WwxIXtaYMBZY+/BisaJ+9jSQiwKBDdGtJd0esLB6PhSOFXzBapgJZmCvkFkGsUiNSKBd
         I4BqRiS/rH3ImTce25fPmhBBnhIXTPt9P59macDthjFZjmPffllI4PrBEyC4mlctDF9D
         Cd/PTUa3utuithIVbmgAGT4JMuCEQGGd8Rttel2fjc0vUvM9fRSiW1VYeElh55V4xSn/
         liaw==
X-Gm-Message-State: AOJu0YxZjlBOsm5kaGa9NrAE23xNxNG5HSKBU4fxbsr0HTql+Ak7cn/l
	Y3myifulkLcsO3PP4qgO9O/MIGWe8Iugo55g5Lck5atVxy+3UPIfA3v7mbp3TXXH4Q==
X-Gm-Gg: ASbGncu43lbkuozrWnLajG84FAvuToYw5G7PRUjcwcQD+qZQKfWSP01AWLIfqduwfQf
	2RPubZKQ0GFfWmPsAOui3t/z5giObUQKTXR3i7b/S+hNc66DszGczyBSCXNcUdHOaC1HEke3eNT
	jDrG4HpgOa2tZ4//bCrAhpzK9Kdll+yvaaGkMUuGqYHebcUVlVZ11s0HOoUE6ct3o7U97l7nXWf
	4OBgGD8AEJltP/9qYFs0ahDzmpqO8exziJi/uvjf+1+h0JpOpT8HNbFNaYI59ps+5McdOc5yddI
	3CeUE6GpMVBriF6NQINxdrNg9J5073M/ZIX5bt+xxO656bM67MIBd9oU8+KJmTpH9yJFEAlQScj
	Q5//dIw==
X-Google-Smtp-Source: AGHT+IE4I61BvY0WA2H/PPUAU74a+Kk77pbH678Q2yDCbI1QsTYdMAWcpLHiZj97tRFpHHxHyWsqwA==
X-Received: by 2002:a17:90b:3c84:b0:2fc:c262:ef4b with SMTP id 98e67ed59e1d1-2fce86cf0e0mr34669501a91.18.1740515738822;
        Tue, 25 Feb 2025 12:35:38 -0800 (PST)
Received: from ?IPV6:2401:4900:1c74:28d5:d718:bd21:53c1:5a5? ([2401:4900:1c74:28d5:d718:bd21:53c1:5a5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3dec52sm2036044a91.20.2025.02.25.12.35.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 12:35:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------04bi2qATsvkNlMS6wjtWZbhg"
Message-ID: <c876024e-f9a0-43d7-ad4b-116b5fa638fa@gmail.com>
Date: Wed, 26 Feb 2025 02:06:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: Pranjal Prasad <prasadpranjal213@gmail.com>
Subject: Follow-up on HFS+ Kernel Improvement Patch

This is a multi-part message in MIME format.
--------------04bi2qATsvkNlMS6wjtWZbhg
Content-Type: multipart/alternative;
 boundary="------------09iHugoz7H0VvvA0KViIZiL8"

--------------09iHugoz7H0VvvA0KViIZiL8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I recently submitted a patch to improve the HFS+ filesystem support in 
the kernel. Upon review, I realized I forgot to include the 
*"Signed-off-by"* line, which is a requirement for kernel submissions. I 
have updated the patch with the appropriate line and have attached the 
corrected version of the patch.

I would appreciate it if you could consider this updated patch for review.

Best regards,
Pranjal Prasad

--------------09iHugoz7H0VvvA0KViIZiL8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p data-start="917" data-end="920">Hi,</p>
    <p data-start="922" data-end="1230">I recently submitted a patch to
      improve the HFS+ filesystem support in the kernel. Upon review, I
      realized I forgot to include the <strong data-start="1053"
        data-end="1072">"Signed-off-by"</strong> line, which is a
      requirement for kernel submissions. I have updated the patch with
      the appropriate line and have attached the corrected version of
      the patch.</p>
    <p data-start="1232" data-end="1306">I would appreciate it if you
      could consider this updated patch for review.</p>
    <p data-start="1308" data-end="1338">Best regards,<br
        data-start="1321" data-end="1324">
      Pranjal Prasad</p>
    <p></p>
  </body>
</html>

--------------09iHugoz7H0VvvA0KViIZiL8--
--------------04bi2qATsvkNlMS6wjtWZbhg
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Added-comments-to-xattr_security.c-in-hfs.patch"
Content-Disposition: attachment;
 filename="0001-Added-comments-to-xattr_security.c-in-hfs.patch"
Content-Transfer-Encoding: base64

RnJvbSA3NzU2MDViZDYzZGU5OTYyMmZhYTYzZDdmOGIwMWI4NjhiMGU1MmFlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQcmFuamFsIFByYXNhZCA8cHJhc2FkcHJhbmphbDIx
M0BnbWFpbC5jb20+CkRhdGU6IFdlZCwgMjYgRmViIDIwMjUgMDI6MDQ6MjkgKzA1MzAKU3Vi
amVjdDogW1BBVENIXSBBZGRlZCBjb21tZW50cyB0byB4YXR0cl9zZWN1cml0eS5jIGluIGhm
cysKClNpZ25lZC1vZmYtYnk6IFByYW5qYWwgUHJhc2FkIDxwcmFzYWRwcmFuamFsMjEzQGdt
YWlsLmNvbT4KLS0tCiBmcy9oZnNwbHVzL3hhdHRyX3NlY3VyaXR5LmMgfCAzICsrKwogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMv
eGF0dHJfc2VjdXJpdHkuYyBiL2ZzL2hmc3BsdXMveGF0dHJfc2VjdXJpdHkuYwppbmRleCBk
YjM5YTg2MzJiMmMuLjg3NmViYzU1NTMzNyAxMDA2NDQKLS0tIGEvZnMvaGZzcGx1cy94YXR0
cl9zZWN1cml0eS5jCisrKyBiL2ZzL2hmc3BsdXMveGF0dHJfc2VjdXJpdHkuYwpAQCAtNSw2
ICs1LDkgQEAKICAqIFZ5YWNoZXNsYXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+CiAg
KgogICogSGFuZGxlciBmb3Igc3RvcmluZyBzZWN1cml0eSBsYWJlbHMgYXMgZXh0ZW5kZWQg
YXR0cmlidXRlcy4KKyAqCisgKiBQcmFuamFsIFByYXNhZCA8cHJhc2FkcHJhbmphbDIxM0Bn
bWFpbC5jb20+CisgKiBJbXByb3ZlZCBhbmQgYWRkZWQgY29tbWVudHMKICAqLwogCiAjaW5j
bHVkZSA8bGludXgvc2VjdXJpdHkuaD4KLS0gCjIuNDguMQoK

--------------04bi2qATsvkNlMS6wjtWZbhg--

