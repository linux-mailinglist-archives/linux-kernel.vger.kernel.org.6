Return-Path: <linux-kernel+bounces-515942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E767A36AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CEB18925BB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05F574BE1;
	Sat, 15 Feb 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCoWvqqM"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8941B59A;
	Sat, 15 Feb 2025 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581921; cv=none; b=OMY1bS67R6i9w3RKWCg1Gws1acouWKCI+Bwq4Vr2vvmpISSBixubOis0yDT+2DqL/HpQvPTEA5Eu0KjIS5FC4cBptVcXtYCcM3b2/Y4+UTuUxVGbidP76EGdRsszhBYKn2VxYth7/PXtgO7PnWZpMzfyvzLgPKKRbmVOjp56J9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581921; c=relaxed/simple;
	bh=d5OFd/G+/NcBl6t+Z0JGUCA4UL5w9rQnPohbFHgNGuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATro7fAFlS1L4/lBxYrLjynmjmIDyeyeLnCrZPVbzumyOg0r2HuiRWGRlhfqdH08zlOo9AYyomDfx5EoZiRyZ6Xhs+IOSxQCqkMfsXlHsFhf2OSmpWiFL8J1JlKV5J5CfwzgPrUSrT+JBIcFNhyEoU7xEEt6mWWU/OniqfO6XtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCoWvqqM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c8f38febso49445475ad.2;
        Fri, 14 Feb 2025 17:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739581919; x=1740186719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhFHpTl87ZgzCdLyiXibfTAHdjueohyf2A6nhIyubNM=;
        b=OCoWvqqM+HQrnBgUdy3pj8HITseJbRk/IhinaYp1RkqrcGWrivzEloIQDeRFV96eZe
         W5fhriBlZDnhpEtoR+K9htkTvdSd362ohWLKAlC3vzC+FzXIl4NE6fq1AALhoCXXgVC1
         Zu2Cnf+kcDBZ/WBo1n6Bdpkilo8qP0p5SOqbkdFTLRRintq+ZTCaiH4mCdPXCc5FapEl
         Mgpzm93U922Ig71BWPR8Rgd3gvrKDdXneqwxwTi1nr4GpGb0VeFNOiTln6E8y7IKbKEh
         z2tWI74hJbGuGIHFJJvSpKPnZzvrhVvQxE68A6qLt0z7Tr/8mGPsi+QCIMZcsUt9BhE1
         hsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739581919; x=1740186719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhFHpTl87ZgzCdLyiXibfTAHdjueohyf2A6nhIyubNM=;
        b=J7S3LnWTM9emWCG1EnPajrxAb/jBZQ7Y3a8udUXsjGCBJemr43e4NNJx0XTt6JAdnq
         0nekGOI9DPk0/l6auazquW7o2ImKj01DOHDLTmY8pbnOPV+97GcsFRdSQd7tbiukUQar
         q1rxEs22V8uVp+MCwwTQz2bCACWByrlp9aSvjoYPiTDMieXDv2WpltQUSGTUoJ8R7RK6
         vXZ9MHxO1g889uxN7/kZoDr6J0Kh+Jw/lSCQ1YuA4VczsCM/orGKyvmtwW3fH0RiY0k6
         BavpRoevh/x3SphHIE4mWXb6pvDy48o8BltKF1Yb4rY6pDh7dWlrapN8jyiXLvuIbFFI
         /LPg==
X-Forwarded-Encrypted: i=1; AJvYcCWCucL8F/osLfAMUi9VxDN7tdGAJWhzBTxL9ZBUHqTzkvsUeLeyni+sjSVHvnIw4barkYg1wUeSOu8pop0=@vger.kernel.org, AJvYcCWUzOBGICoNXBmeQjzK3FhN9vGOocxjrR06W/vPD1ZPjhVaws8SeGyx+FewpN9V0hzRwbLL7KNQwcnorHBmoZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwRgAqSLQA6+x4Tgfkd/F40TXJpNmjNxIrCOtwsXtj/tCgIS3
	vkutVZJCskhGQEQy4oDzdhR+Z3LtoqzrRO+pD/OEFfeKthotHPEj
X-Gm-Gg: ASbGncuURlX9lHKJLmyu2/ph/SKYwckS/VJrFRDm7z8DFOg1XSXPV3TRUS3W2peqsGA
	QpHftcv1e1QJB/hkDveugKqr5AlJXr6TeyROLI9xKnTx5oiDipO/OEeKEDx9VbmYfeCP0/z8BDD
	yN3cHtrhFy0U2zbVwJ/3Er3xrTO+uGTPBjpDUnXwBMXx/yc16z4pPZRS8A9SgypbLaMsQ8yFXpc
	X36xxPQO49voxYBv1IbHHBO7mc/OA4UGkt0IK7e5NLRKVbBiwekS47w5pX0fgPaDbbli9X8UwBN
	qU4d/QqFfCC1NVqjQZkuDsCg
X-Google-Smtp-Source: AGHT+IEA+0WyWlGsJ3YtsaFpMbR6Tv2W6sdVwfSW81viOVw30z3CtEWxoKbRnwimjE1Wg5HIlf6K4A==
X-Received: by 2002:a17:902:dac5:b0:21f:4b01:b985 with SMTP id d9443c01a7336-221040bc38bmr20532935ad.45.1739581919030;
        Fri, 14 Feb 2025 17:11:59 -0800 (PST)
Received: from linuxsimoes.. ([187.120.159.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5586141sm34906035ad.227.2025.02.14.17.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 17:11:58 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: charmitro@posteo.net
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	miguel.ojeda.sandonis@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH V2 1/2] rust: module: change author to be a array
Date: Fri, 14 Feb 2025 22:11:45 -0300
Message-Id: <20250215011145.146552-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <m2y0y8b7p0.fsf@posteo.net>
References: <m2y0y8b7p0.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Charalampos Mitrodimas <charmitro@posteo.net> wrotes:
> I wonder if we should make this "for author in authors", for code
> clarity concerns.
You is write, I will make this change.

> It could be that you developed this with an old tree history. You missed
> changing the author for the samples/rust/rust_driver_platform.rs sample.
Yes, my bad. 
I will include this driver

Thanks,
Guilherme

