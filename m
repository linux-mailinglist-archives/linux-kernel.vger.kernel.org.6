Return-Path: <linux-kernel+bounces-359092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A873998750
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85AF286A32
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0967C1C9DFB;
	Thu, 10 Oct 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReKgXmFO"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E711C6F76
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566059; cv=none; b=TKKDKtXzrxgEHWD5P0m49fumbwNoSIvyGP+8swTJGJN+HUZfmN4RJbuNXzf6c/fqoV3BhdJWzgLv9V89QwFwiDfp4XUg/DYI31G4rKjmjkr2mf26YYHKWGCF+743x6x8oG7flzCbFJNj9ij7bhXmar7/WGu9b+pAzq8+ix2THb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566059; c=relaxed/simple;
	bh=YU6urOR42qhpIUjlXGY/7CZ+SSO7d4OvESK8V2J5YU4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ewzZGVw3eIhh5utW4VFqGhKnOT8ZE/OEkYOF+VFQkPRYtf+p+vYlpK6NAzoiArMJ+bJvia6FT0LSbMDy9kvIIrStz2UEzQRVqh3He/OBqtThp/YEpqr8YVVSpscsJ3UpzDmCzvbypYN/L1Z5WwO/fSLq7tUfCzlWIvEClGtwveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReKgXmFO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2840bb4a0so759334a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728566056; x=1729170856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4GaB3BvDEztYkwG5TskcAZxl5Uo5JYHU0JNVapVY7mE=;
        b=ReKgXmFOYchleAR8D4uQ3/yES8PL25oqrLnoN7uoWtSy3AuqgGGxrcD9N8iv7DKLD+
         pADs9VN/EWJLQyqAN1gpW1kA+/xMW/F/3nir06mHtsvRfrpx1Tut+CGwQBsrm5rnJskt
         VrILLuoGFnsLiZ3MB2GepaaVIfk+kpkJNwanyR6Gd486iOgnNlha6N7x7IpawyXJHbXH
         ahZa6VVtUnpdwbqHE6XyGRyiFV9hpJc4LVIOQ4D8hcxoKGZrHYH5xLEzAKBQ/xJEsGUC
         EnC8RXlIW35Q5c4NKgEat7zue4UPE1Ihz7fFvycxHRcnJ0njvFdLs3P61lUdT7cfIW7m
         Ku1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566056; x=1729170856;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4GaB3BvDEztYkwG5TskcAZxl5Uo5JYHU0JNVapVY7mE=;
        b=oe9/sPt+UI/ELx4NUZLZKfuGMkPkaxtTNOmbsipULkrytu+EJ8ttb+YM0BknmgGRwP
         UrIPRPNiRENoLepUjtGolk61okBjmFZmg97vnlg/2NMYO2bdFBK3zSSy+BigAmtFS9GL
         ShhpHKT7hKyF0xpeiriHqZ3w4AQvjySuUFej3cR69VB9Icf3AW5mvPxANK3YEZKbPEzu
         G659StIstFLfB/kWxGjXxsTHlr3lfUX89fhaTA85Me6GXpVH/WNJg6JUrxQCsCwGNxA1
         xAohy2q1pLNTJqb7U2sZCHaf+o5ucfBmLs1f2i5dV0mrVmn2vIMPeHc18l0+kR/j3LrS
         mBDQ==
X-Gm-Message-State: AOJu0YzsmzAxGRHMbbuF/3sfllDPOhwKVCbbCqIbJXAbMEcpCVOu+Co6
	pK758B8+tY624SWXrvsyW+bonCnS0RshSOp0ESAVTcUSo9iWdL4tDV9OCKR7NsaCXfXtkEDdHAt
	tDv2sVxPZc4cwPCqPxCURE0C7SFI=
X-Google-Smtp-Source: AGHT+IH/kJ9v9I4hTvG8dUqT1oURemKJUtA75dh+2yTj6zWmkTZOLpZw4/Wo2lZk76cNxXaCrMmRQFrnMFlMMsCme+M=
X-Received: by 2002:a17:90b:3911:b0:2e2:8fb4:502d with SMTP id
 98e67ed59e1d1-2e2c6333914mr3763104a91.16.1728566056054; Thu, 10 Oct 2024
 06:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Thu, 10 Oct 2024 18:43:39 +0530
Message-ID: <CAG-Bmoc95jEr_WDNmqyCDb=CPOE2+-5MytXiNR-uy87jXbWD2g@mail.gmail.com>
Subject: UBSAN: array-index-out-of-bounds in dtInsertEntry
To: syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000be86d006241f2512"

--000000000000be86d006241f2512
Content-Type: text/plain; charset="UTF-8"

#syz test

--000000000000be86d006241f2512
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-jfs-fix-array-index-out-of-bounds-in-dtInsertEntry.patch"
Content-Disposition: attachment; 
	filename="0001-jfs-fix-array-index-out-of-bounds-in-dtInsertEntry.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m23bkoj20>
X-Attachment-Id: f_m23bkoj20

RnJvbSBiZGM5NTZhMzg3NjJjZGE5N2I2OWIxNjRmNTVjZGI5NGY2ZjljYmUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHaGFuc2h5YW0gQWdyYXdhbCA8Z2hhbnNoeWFtMTg5OEBnbWFp
bC5jb20+CkRhdGU6IFRodSwgMTAgT2N0IDIwMjQgMTg6MzY6NDMgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBqZnM6IGZpeCBhcnJheS1pbmRleC1vdXQtb2YtYm91bmRzIGluIGR0SW5zZXJ0RW50cnkK
VG86IHNoYWdneUBrZXJuZWwub3JnLAogICAgb3NtdGVuZGV2QGdtYWlsLmNvbSwKICAgIGdoYW5k
YXRtYW5hc0BnbWFpbC5jb20sCiAgICBlYWRhdmlzQHFxLmNvbSwKICAgIGdoYW5zaHlhbTE4OThA
Z21haWwuY29tCkNjOiBqZnMtZGlzY3Vzc2lvbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQsCiAgICBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCgpUaGUgdmFsdWUgb2YgcC0+aGVhZGVyLmZyZWVs
aXN0IGNhbiBiZSBsZXNzIHRoYW4gemVybyB3aGljaApjYXVzZXMgYW4gZXJyb3IgaW4gZHRJbnNl
cnRFbnRyeS4gQWRkZWQgYSBjaGVjayBpbiBkdEluc2VydAp0byBhZGRyZXNzIGl0LgoKUmVwb3J0
ZWQtYnk6IHN5emJvdCs1ZjdmMGNhZjk5NzllOWQwOWZmOEBzeXprYWxsZXIuYXBwc3BvdG1haWwu
Y29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTVmN2Yw
Y2FmOTk3OWU5ZDA5ZmY4ClNpZ25lZC1vZmYtYnk6IEdoYW5zaHlhbSBBZ3Jhd2FsIDxnaGFuc2h5
YW0xODk4QGdtYWlsLmNvbT4KLS0tCiBmcy9qZnMvamZzX2R0cmVlLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9q
ZnMvamZzX2R0cmVlLmMgYi9mcy9qZnMvamZzX2R0cmVlLmMKaW5kZXggNWQzMTI3Y2E2OGE0Li41
MWJiM2UxNDU1MWIgMTAwNjQ0Ci0tLSBhL2ZzL2pmcy9qZnNfZHRyZWUuYworKysgYi9mcy9qZnMv
amZzX2R0cmVlLmMKQEAgLTgzNCw3ICs4MzQsNyBAQCBpbnQgZHRJbnNlcnQodGlkX3QgdGlkLCBz
dHJ1Y3QgaW5vZGUgKmlwLAogCSAqIHRoZSBmdWxsIHBhZ2UuCiAJICovCiAJRFRfR0VUU0VBUkNI
KGlwLCBidHN0YWNrLT50b3AsIGJuLCBtcCwgcCwgaW5kZXgpOwotCWlmIChwLT5oZWFkZXIuZnJl
ZWxpc3QgPT0gMCkKKwlpZiAocC0+aGVhZGVyLmZyZWVsaXN0IDw9IDApCiAJCXJldHVybiAtRUlO
VkFMOwogCiAJLyoKLS0gCjIuMzQuMQoK
--000000000000be86d006241f2512--

