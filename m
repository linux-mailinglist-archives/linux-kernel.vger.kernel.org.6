Return-Path: <linux-kernel+bounces-219636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F590D781
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA5CB2EA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AC014BF86;
	Tue, 18 Jun 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Ku35k3sK"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09E12B95;
	Tue, 18 Jun 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721475; cv=none; b=p2CY1m+WO/KIQLuxfA2nFildPdrq7zJ9xE+gaMaQcPbeJtCjR5qX6fhEmOrYxdh257PkqpCb3a8lrIKbK3OfEAOjrBLacfHXQa39AbMXvGkMh6mRlj6B70AFpoujfFLUS/e/7cLABBUtXjOGkCAYmXIr+nEdqoTwrxbHEqYLcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721475; c=relaxed/simple;
	bh=na6KOdcwocOVWP2D6fkDzWxcGI4FluP9gWc0IEeBvPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eXyanUxR6wFbnkPYZZogsQ9F9ehIqij0CvfjhehdioEdU80Jbio0sI2v1SgKqiHn/leRM94flEuugT0uF6/zEZ2NtOgH+uvExSCYSXRrOsg3PeaWeXuBbNt39C32dcbTebCLdAjhQdhyDEBRk+ogLr3zBnxF0RsYNkoxN5Q7Zio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Ku35k3sK; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45ID7VG6016852;
	Tue, 18 Jun 2024 14:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	DKIM202306; bh=6Mjw2tZfiMJ6uFQ21cibQZKdgxepVkmAZq6TGlRIs6s=; b=K
	u35k3sKb/hwe5r6DQ+an+DiZErYoP+FlxXltcHOVH0ZpyQnC0QYc/bRGfemHQYda
	SI5DWRGAWxNKAQQdJOpfbDnRU6MCkmGGJQuAq5ZdP9YdVLu6o6v3O9JrHysPno27
	86TqMRK9zrfSrrI4athTEedOvHuWkt4mDRvk0+TSW0VKG5QQkE1imAuNV3QHc8X0
	yhtfumdL3xRjS5A0LVuO/AlqMUMiXzsxI6teCrQbvA6JXSFPzNw2MD3MBhNhpS5J
	WTQk5jq5mf5cAQp9BbzMwq//CJwNNDUb4mVDQ+VCGiQFAbbcdBf8YKmszcFdSWfN
	XpwZxk7c8gUtnkZemuYMg==
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by m0355090.ppops.net (PPS) with ESMTPS id 3ysp9ry6sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:37:34 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4W3Tqf0Zkyz4yjWh;
	Tue, 18 Jun 2024 14:37:34 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W3Tqd65lDz3p6jp;
	Tue, 18 Jun 2024 14:37:33 +0000 (UTC)
Date: Tue, 18 Jun 2024 09:37:32 -0500
From: Maxwell Bland <mbland@motorola.com>
To: linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Maxwell Bland <mbland@motorola.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] ptdump: add intermediate directory support
Message-ID: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: sc6QcvRW6h6thBBf9R7Kxq_tsknsRC8q
X-Proofpoint-ORIG-GUID: sc6QcvRW6h6thBBf9R7Kxq_tsknsRC8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180108

Makes many several improvements to (arm64) ptdump debugging, including:

- support note_page on intermediate table entries
- (arm64) print intermediate entries and add an array for their specific
  attributes
- (arm64) adjust the entry ranges to remove the implicit exclusive upper
  bound
- (arm64) indent page table by level while maintaining attribute
  alignment
- (arm64) improve documentation clarity, detail, and precision

Thank you again to the maintainers for their review of this patch.

A comparison of the differences in output is provided here:
github.com/maxwell-bland/linux-patch-data/tree/main/ptdump-non-leaf

New in v4:
- Inclusive upper bounds on range specifications
- Splits commit into multiple smaller commits and separates cosmetic,
  documentation, and logic changes
- Updates documentation more sensibly
- Fixes bug in size computation and handles ULONG_MAX bound overflow

v3:
https://lore.kernel.org/all/fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt/
- Added tabulation to delineate entries
- Fixed formatting issues with mailer and rebased to mm/linus

v2:
https://lore.kernel.org/r/20240423142307.495726312-1-mbland@motorola.com
- Rebased onto linux-next/akpm (the incorrect branch)

v1:
https://lore.kernel.org/all/20240423121820.874441838-1-mbland@motorola.com/


Maxwell Bland (5):
  mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
  arm64: non leaf ptdump support
  arm64: indent ptdump by level, aligning attributes
  arm64: exclusive upper bound for ptdump entries
  arm64: add attrs and format to ptdump document

 Documentation/arch/arm64/ptdump.rst | 126 ++++++++++++-----------
 arch/arm64/Kconfig                  |   1 +
 arch/arm64/mm/ptdump.c              | 149 +++++++++++++++++++++++++---
 mm/Kconfig.debug                    |   9 ++
 mm/ptdump.c                         |  21 ++--
 5 files changed, 217 insertions(+), 89 deletions(-)

-- 
2.39.2


