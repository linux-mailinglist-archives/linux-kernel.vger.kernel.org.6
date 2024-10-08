Return-Path: <linux-kernel+bounces-354697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1959099412F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB326285E5B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BF51E00A0;
	Tue,  8 Oct 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwV1GYHE"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403571DFE3C;
	Tue,  8 Oct 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373739; cv=none; b=vDiBCi7cCzR/QyEGylx5z0twws3VIg+x8KDq7ralgYVyAGwkgR2Ff4FpENjvpePIWJmN4+sCuun3H2gw8lzXzu0jIIMGBXtb6/GLyOIg9y55g+8oo5kjNRIi49KA8vOpdQ3qfgyTWS58b7QjMNybYO0UvD7EtXoANSyoCqEn2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373739; c=relaxed/simple;
	bh=bA8/SVYlYdZngnDmGUoO6FHKbaDxUuXbNbeOYz6c8is=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sQGAttuVDjXo12ztPTd0ePee/qNdEA7X42BKypckmjQF2PHE2iRkrZSvZzAL2fPZsJOSI+GJaE34J9ZlBjNmNUYLIXpynxiV5KA1JbDWLx3XrUcmYDgSEPP6uI80ZqxsVdvfqeUNMXb3j0YlU9OMO3F810uVz8iaWImgrSmLtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwV1GYHE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0d9b70455so4095792a91.3;
        Tue, 08 Oct 2024 00:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728373737; x=1728978537; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bA8/SVYlYdZngnDmGUoO6FHKbaDxUuXbNbeOYz6c8is=;
        b=dwV1GYHEeRR7xqz0dPIuZ1T9pyIgr/EPtOGTknshM5985neiYmNRyE1WMzakzOxmM8
         QfhKjmtmbmgPYX/Han2rtt/Ly1hIeWg2BfUrZmH5xG17mC+Of4W+OCQJl4onKWiIistn
         cbQKLyRng1vrYmF/DrjKoyN8BvuwiEQu2BBPEv41sFu+MhlO1uM+yJeKT5BB+BwtmWXL
         SORY5ugmdQw00RdQjhrPGfsp0nbcHgeJkbvxJM8MciFpK8j6U6qefxa3YkArOOLyB/0j
         kX4W/i5PP6zBUAN+wAxnMHkZhYpbYQu+L7GK0meH52IGRn7OZUwsgnu98+hHi5hfGroS
         Gy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373737; x=1728978537;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bA8/SVYlYdZngnDmGUoO6FHKbaDxUuXbNbeOYz6c8is=;
        b=cRS3IXSeGN3wsPIfewnLHJtUHNTNyD4i++0OMdoymu9S7ta8lbD8VUiGTmFcAmzyrt
         Z4o3kQtIGTJjYzQ6oGpLZlTkJzlO9xidMVXjQ/S9M3RcysmUPt/X4HK7Rrc5InL9fsJD
         YB8Z95ZQDvgyV6trj6flLdQpw8FhRafrRZrdO4O/t9rk19gUCsl7ufFF7ONl7JuGCE1V
         PWSEz6wEYuKz/arIP0f9mQ5upn+Em97c0mcNs5qOtiFwZQQ408SrfKdStiNc3M7Rf84Y
         IHIWzlKHUfGFcVuaS6x336uQ32sIR1/vjdVkF9FLK2Wf8Xda2I5fbxR2WPMWz8TzgpLY
         2Ltg==
X-Forwarded-Encrypted: i=1; AJvYcCUpt+QpTqvO7Y0dCdRb7jSC9CYHpLVBwAhsuhPGciPm0/Cuxv3TyMligLlYIkHoGM7BrsWf7LyiqVHm@vger.kernel.org, AJvYcCWKGEkapoAOXJQYfOytQN2bpjXwvYFovsdJZRSd1zkWGkhN3/+rn1SkNf0KFno/JqbP7iVERG3bvPr/dNB7@vger.kernel.org
X-Gm-Message-State: AOJu0YwldElSOz+X5xq2iI/C/C2BmASS+cY8jDerS5cV0zzN4TrczI0+
	UVPxWd49A/AfhvA2F+pbfxMjDd2nYyMTjOQURx9bxjt+DceRb5BZ
X-Google-Smtp-Source: AGHT+IErgU2lhExs25qWrVDEDDHSGx9Xkj/N08LVXzRxU9AH6TiBRcn+BcRRKUGwzhdRig6cMz2MRQ==
X-Received: by 2002:a17:90b:315:b0:2e2:8d33:f7a8 with SMTP id 98e67ed59e1d1-2e28d33f84emr423120a91.7.1728373737424;
        Tue, 08 Oct 2024 00:48:57 -0700 (PDT)
Received: from TYZPR04MB5973.apcprd04.prod.outlook.com ([2603:1046:c09:1962::5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85da3f0sm8511251a91.30.2024.10.08.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:48:57 -0700 (PDT)
From: xiebo bo <xiebohao1234@gmail.com>
To: "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>
CC: "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "apatel@ventanamicro.com"
	<apatel@ventanamicro.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux@rivosinc.com" <linux@rivosinc.com>, "mick@ics.forth.gr"
	<mick@ics.forth.gr>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"seb@rivosinc.com" <seb@rivosinc.com>, "sunilvl@ventanamicro.com"
	<sunilvl@ventanamicro.com>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v7 0/7] Linux RISC-V IOMMU Support
Thread-Topic: [PATCH v7 0/7] Linux RISC-V IOMMU Support
Thread-Index: AQHbGVZ6glD/G7fCRUu+7C/pNa2TDA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 8 Oct 2024 07:48:52 +0000
Message-ID:
	<TYZPR04MB5973A5633B25CA29FC81AAE1AD7E2@TYZPR04MB5973.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgYWxsLApJIGhvcGUgdGhpcyBlbWFpbCBmaW5kcyB5b3Ugd2VsbC4KCkkgaGF2ZSBhIHF1ZXN0
aW9uIHJlZ2FyZGluZyB0aGUgcHJvY2VzcyBvZiB1cGRhdGluZyBwYWdlIHRhYmxlIGVudHJpZXMg
KFBURSkgaW4gdGhlIHN5c3RlbS4gU3BlY2lmaWNhbGx5LCBpZiB0aGVyZSBhcmUgb25nb2luZyBh
Y2Nlc3NlcyB0byBhIFBURSB0aGF0IGlzIG5vdCB5ZXQgcHJlc2VudCBpbiB0aGUgSU9UTEIsIGFu
ZCB0aGUgUFRFIGlzIHVwZGF0ZWQgd2hpbGUgdGhlc2UgYWNjZXNzZXMgYXJlIHN0aWxsIGluIHBy
b2dyZXNzLCB0aGVyZSBjb3VsZCBiZSBhIHNjZW5hcmlvIHdoZXJlIHRoZSBzeXN0ZW0gZXhwZWN0
cyB0byByZXRyaWV2ZSB0aGUgb2xkIFBURSB2YWx1ZSBidXQgaW5zdGVhZCByZXRyaWV2ZXMgdGhl
IG5ldyBvbmUsIHBvdGVudGlhbGx5IGxlYWRpbmcgdG8gdHJhbnNsYXRpb24gZXJyb3JzLgoKSG93
ZXZlciwgSSBoYXZlIG5vdCBzZWVuIGFueSBtZW1vcnkgYmFycmllcnMgb3IgbG9jayBvcGVyYXRp
b25zIGluIHRoZSBjb2RlIHRvIGVuc3VyZSBwcm9wZXIgc3luY2hyb25pemF0aW9uIGR1cmluZyBQ
VEUgdXBkYXRlcy4gQ291bGQgdGhpcyBjYXVzZSBhbnkgaXNzdWVzIHdpdGggdGhlIHRyYW5zbGF0
aW9uIHByb2Nlc3M/CgpUaGFuayB5b3UgZm9yIHlvdXIgdGltZSwgYW5kIEkgbG9vayBmb3J3YXJk
IHRvIHlvdXIgaW5zaWdodHMgb24gdGhpcyBtYXR0ZXIuCgpCZXN0IHJlZ2FyZHM=

