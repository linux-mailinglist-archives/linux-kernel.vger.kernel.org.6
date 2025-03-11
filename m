Return-Path: <linux-kernel+bounces-556438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7097BA5C8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872C81888A96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E39025F783;
	Tue, 11 Mar 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh2Ia8hC"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391F255E37
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707894; cv=none; b=MphuV9yi2TdBwWhUz9P3xNdp22p9jFwxkk34WMJfFrbXssLUi479y6hNv/jPwufcG5YxMXCnFh8YtjuEJTiMNf29VlZxjF06qY9QthkRb0UyZn8hEEfSrwQN+qbc0O6gPzIPUS1KW5i5K7PGs0Z/EJtbkwNvzN4cORavvHGPYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707894; c=relaxed/simple;
	bh=A8lLSHH7koinx09SGDGiYPP7dnY4B81EBv/d0OMEEcs=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=uUJplGfgg6wEIDJlbZymDQCatDXl4rtbX+Gr3+H+U4wu/T3nQhiXRD5NkaYcccvP8MsoLnPwjzlEtHZzFJqiteyoSsMSxJv+LQ+dNveRh6LS121zQurVfc78qSvDv0yLuGTwGkhocqYKbZ/5HGp+kbBzu45MyRk592xCS6V1OsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh2Ia8hC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so34185625e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741707891; x=1742312691; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A8lLSHH7koinx09SGDGiYPP7dnY4B81EBv/d0OMEEcs=;
        b=Fh2Ia8hC1N7/YWAfmRicuj8DLdlqcBCHlLZS1P/EPs0MuNeca7zw8quxes2a+Wq8rX
         fb4PUy8mUERgDMKLevsPN5xEu7unsbMBAmj2b0OuzobO1szYCQDcA1SC44wWmpCv85UO
         TUsATa/uykCVHDgoxvcAOzgfX76E+ONFolv6vmLLoZeGeiHhvzt6x0wc+osmnGq7GA2n
         hNp7FdLy5ca16O1tV2sy/X8TBR0fTe1dnWlpsNnvH7nqTury/qepuD2Sm5fXw7aoh9O2
         oSiGvDqGFc5f8m6i8WGliqVby+yn5plHsrK2B2TaQJm3+zlOkGzeqEsZ3UPJE/bACFRq
         0zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707891; x=1742312691;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8lLSHH7koinx09SGDGiYPP7dnY4B81EBv/d0OMEEcs=;
        b=cEWuGaaxC4YHEAU03p1+qEvyMDMF5o6xkBSq2vOf506r2xQEmU5az15XS/JUchY5h+
         VfNWbSjbfUneFer4JEEGisOmQy4JhLTwILpXEuozctSt6SErfBKElY5+K23eSkw8b5IE
         I5vpi4IPeHLLSmYblNXeDIld8gb2Swk3s73hNhrUIKzOi2+b6GyMwVEjqwI5JMF+SErH
         aPNaCNAaDt9t0qDX7xXnW2rkSG5ysB2bIS0If7LvaoME2rA0qu9M6oLqntWJODKvDZ1v
         1sC3Vbx/TPZ0x1gR9UwDHadVTu1b0MHzj7R3OgGEFA+4Of7OVPkSTle+GvAW6ernfXWo
         NWWQ==
X-Gm-Message-State: AOJu0YxBGzfnNsDzGfH6JudXxEY6NQmzR0o0zsftUsY+qomuc/SjKto3
	bTi7eUTGgHvyGtmhcwbWTb9oBWHrSXIFiFM4zPR9VHfz9L+szRUjysgA/Q==
X-Gm-Gg: ASbGncs+aP9EnY5O9SXB9p7vQQQn/vF489khUbcNc9ZzfZkocIys5ZLFzuzQZvNT6QC
	u6hsUlWFIp3PGSY24tez4bCB0MYAm3XGPF4R4wNtywHik58d1K7TnpuRp99vuR2VSC2/WF0zmPi
	J6jgBUTkxvsOUfw5QuP8u6kH90Qcvmy5Gg8xe/aDhhcE4hGNBUbAjYnu/jAgNVTxJZBWmvBqegF
	1RCx6bIh2t3FJyYKA/314xdJwF6j+JI47a8WreqihVfqbtygzz9C1Blg01VIfHytIdQx3eXfANu
	UBakO6a3kNuXIHCjy0/dCkeV1q46ro6dj1GlgZ94TOF340AO59jafGhg3FBF2Uem84ZVwClITHk
	=
X-Google-Smtp-Source: AGHT+IG4OdTidYgn2ASGoKST1qrz0bt/nppFFQJL/xL1uwhfRzAAtLJs/sBPZ6MhKlaWJA9PI7ljaw==
X-Received: by 2002:a05:600c:358f:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-43d01be65cfmr61077865e9.16.1741707891066;
        Tue, 11 Mar 2025 08:44:51 -0700 (PDT)
Received: from DESKTOP-A54QG66 ([39.46.225.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce48165c0sm131452845e9.26.2025.03.11.08.44.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 11 Mar 2025 08:44:50 -0700 (PDT)
Message-ID: <67d05a72.050a0220.16956.0911@mx.google.com>
Date: Tue, 11 Mar 2025 08:44:50 -0700 (PDT)
X-Google-Original-Date: 11 Mar 2025 11:44:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: yacine.mypackagingpro@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Personalized Bags and Boxes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksDQoNCldlIG1ha2UgcGVyc29uYWxpemVkIHBhY2thZ2luZ+KAlHR1Y2sgYm94ZXMs
IENCRCBib3hlcywgbWFpbGVyIGJveGVzLCByaWdpZCBib3hlcywgYmFrZXJ5IGJveGVz
LCByZXRhaWwgYm94ZXMsIHNob3BwaW5nIGJhZ3MsIGxhYmVsIHN0aWNrZXJzIGFuZCBt
b3JlLg0KDQpTaW1wbHkgcHJvdmlkZSB1cyB3aXRoIHRoZSBkaW1lbnNpb25zIChMIHgg
VyB4IEgpLCBxdWFudGl0eSwgYW5kIHByZWZlcnJlZCBib3ggc3R5bGUsIGFuZCB3ZSds
bCBwcm92aWRlIHlvdSB3aXRoIGEgY29tcGV0aXRpdmUgcXVvdGUuIFBsdXMsIGZvciBh
IGxpbWl0ZWQgdGltZSwgd2XigJlyZSBhbHNvIHByb3ZpZGluZyBjb21wbGltZW50YXJ5
IGRlc2lnbiBzZXJ2aWNlcyBhbmQgc2hpcHBpbmcgb24gYWxsIG9yZGVycy4NCg0KVGhh
bmtzLCBhbmQgbG9va2luZyBmb3J3YXJkIHRvIHBvdGVudGlhbGx5IHdvcmtpbmcgdG9n
ZXRoZXIuDQoNCkJlc3QgcmVnYXJkcywNCllhY2luZSBXaWxidXINCk1hcmtldGluZyBF
eGVjdXRpdmUNCk15IFBhY2thZ2luZyBQcm8u


