Return-Path: <linux-kernel+bounces-541969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC7A4C3FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF38918848C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E076213E7D;
	Mon,  3 Mar 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oGuLpio1"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E04213E62
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013962; cv=none; b=L60eBD0tr14exAMBSCCXx7aimR29RfFM+4g4G1aAlIJInVIw4fjqj9e+dhI/+DA3RIpugqtv2Iz3JvaeGK5y6uqk5lALtdgtB2LhkjIRd4u/XspxE+Em45U4s1JEpS6e6ow4TCjo5MhUXmMkzO9ZASOZ/f1yZdADNQcB7MJKHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013962; c=relaxed/simple;
	bh=2p8joFJXzZciQEtOaiKD3tMaTCY09PkvoDJBgirMmUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=tTlD3p0IHZyuuKYWjdaq+jcaj4ZBxM7Qvsc0RPOpAjzjIoCroQJlnM2CsJwezxreuWSbXu577hCGWkqeuXslKBMztm3qF/NtW/92PU5545WMjEqdreVhOZPmn7Kdhou159XnDVVuObLFK2vvpgR/Xz8kwNvK130lY56tv81fmn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oGuLpio1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250303145918euoutp011d7609287f1e9f49a671dba4e4747fea~pUvimzY_Q0490504905euoutp01B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:59:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250303145918euoutp011d7609287f1e9f49a671dba4e4747fea~pUvimzY_Q0490504905euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741013958;
	bh=XEcDJFcbja1D97z3Z+kckgPRPhSOypNgkh6K3+gjOSY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=oGuLpio1RvbmIWbCeeU102zVslrnwLXWdDBNwgQjlFOkuV33T9clMejFReui6+dEz
	 I7WqrUVHF0g6F+cYHbHw1DBS1BU8UZgUNKBhFqeZHxRunsMK2L/WtW4DTgs4G846Ei
	 H+RdvqhmaOEuQhwkj87mqlfvYDemcc65qaT7JrJs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250303145918eucas1p126c2cb0be2a456e62b4654a1552c7da3~pUviLu-6Z0745207452eucas1p16;
	Mon,  3 Mar 2025 14:59:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D4.50.20821.6C3C5C76; Mon,  3
	Mar 2025 14:59:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250303145917eucas1p171f8fcccadddc035f5773f7026a281e3~pUvhin3Eu1309713097eucas1p18;
	Mon,  3 Mar 2025 14:59:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303145917eusmtrp16eca5e99ae115c6c12ddf406c8523d16~pUvhhy2g52312323123eusmtrp1W;
	Mon,  3 Mar 2025 14:59:17 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-7f-67c5c3c62dd0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.1D.19654.5C3C5C76; Mon,  3
	Mar 2025 14:59:17 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250303145916eusmtip23651f23fd9a7ab0b85511596a1b416c3~pUvgq0rQa0239102391eusmtip2G;
	Mon,  3 Mar 2025 14:59:16 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 0/5] TH1520 SoC: Add AON firmware & power-domain support
Date: Mon,  3 Mar 2025 15:58:56 +0100
Message-Id: <20250303145901.446791-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7rHDh9NN9i4SNji2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdxWWTkpqTWZZapG+XwJWx89ZF
	5oKD/BUbGg+wNzD+5O5i5OSQEDCRePryAHMXIxeHkMAKRolPrz4zQThfGCW2HbjACuF8ZpRY
	cfwpO0zLvO/TWEBsIYHljBJXD7JAFL1hlDh88wwzSIJNwEjiwfL5YN0iAv1MEn1H/oM5zAIr
	GSXuXzgLViUs4C1xdNtzoAQHB4uAqsSDqQEgYV4BO4l120+yQGyTl9h/EKKcV0BQ4uTMJ2Bx
	ZqB489bZYIdLCMzmlNh0q5cdZI6EgItE9+FCiF5hiVfHt0BdLSNxenIP1Mx8iQdbPzFD2DUS
	O3uOQ9nWEnfO/WIDGcMsoCmxfpc+RNhRYtG1F6wQ0/kkbrwVhLiAT2LStunMEGFeiY42IYhq
	NYmpPb1wS8+t2MYEYXtIdMxqZ4UEW6zE5uu7WScwKsxC8tcsJH/NQrhhASPzKkbx1NLi3PTU
	YsO81HK94sTc4tK8dL3k/NxNjMBkePrf8U87GOe++qh3iJGJg/EQowQHs5II7632o+lCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeRftb00XEkhPLEnNTk0tSC2CyTJxcEo1MKmqFy64I35ve2De
	os9nhJ9+YnFecD5t1galRUvE7k6cMrsz91l6Gn/c84kmFQemrjaIv2JxX5y1TcRn9p8KSR5j
	iUeiK/l3K4RuedR/w3SxKMsz54Ta75YXkuruur81zFzustjrk9Am6e1OXmWzK0TyDGSvnzA+
	pfWk2DPnqsQMrpehl0t0Y7nqz60++vCervKEJPfYW4HfjNIDlfy5NQ9f+5n98x+z+5xWo8bF
	mr9TVq34pHRJbmpLlLUT70Lm3HcO/1OWfzNVrxf57bDYMbxFumfL1WTxI6kHDbZlN3NM/Ga8
	cafWX+fsTUFbXcQnXAx/IxZ2W+yv095dBY+Dfr1ZyfMr5UAm78H0rXtb3iuxFGckGmoxFxUn
	AgDxV4fw9QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7pHDx9NN1jwT83i2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdpWdTlF9akqqQkV9cYqsUbWhh
	pGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex89ZF5oKD/BUbGg+wNzD+5O5i5OSQ
	EDCRmPd9GksXIxeHkMBSRon7Xc3MEAkZiWvdL1kgbGGJP9e62CCKXjFKzL27H6yITcBI4sHy
	+awgCRGBhUwSV6dsYAZxmAXWMkocvnqJHaRKWMBb4ui250BVHBwsAqoSD6YGgIR5Bewk1m0/
	CbVBXmL/wbPMEHFBiZMzn4DFmYHizVtnM09g5JuFJDULSWoBI9MqRpHU0uLc9NxiI73ixNzi
	0rx0veT83E2MwFjcduznlh2MK1991DvEyMTBeIhRgoNZSYT3VvvRdCHelMTKqtSi/Pii0pzU
	4kOMpkDnTWSWEk3OByaDvJJ4QzMDU0MTM0sDU0szYyVxXrYr59OEBNITS1KzU1MLUotg+pg4
	OKUamGQPJ/ieYS9QNuN/ekAqJVXng/VKQ4W379KUbhWbsO96wOKcwvjsyLEVjyxYDhYFz6i4
	ocn2oL7XSarjG/O2hvDXDxoLah/tEDss+EbxANOCzlWhx/YWJZuJMWWZ//v8uEzi+envsaz7
	H5Z7/+c/8O9g9e06tari07F3xDZkzlltu/9k79/6rQsXSDQv3P/8YsHuiZvT5dYGW+Zd3Rj6
	Z6P3L9aN64PbMgzDNWWK+nnrXA1OrVDlmjR90uJCIX6rrydnr1e9uZEjTO1i3MwCnUdHBYzN
	Y0yrbYPTtmpoX9/4xWeXx03urev3XJn0rVZXJUpmdV5BT/lumQb7azLqzDuX2ZwLY/NgUTth
	er3mthJLcUaioRZzUXEiAIi+4D1OAwAA
X-CMS-MailID: 20250303145917eucas1p171f8fcccadddc035f5773f7026a281e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303145917eucas1p171f8fcccadddc035f5773f7026a281e3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303145917eucas1p171f8fcccadddc035f5773f7026a281e3
References: <CGME20250303145917eucas1p171f8fcccadddc035f5773f7026a281e3@eucas1p1.samsung.com>

This patch series introduces and documents power management (PM) support and
the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
upstream, these patches can merge independently.

Bigger series cover letter:
https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/

Michal Wilczynski (5):
  dt-bindings: firmware: thead,th1520: Add support for firmware node
  firmware: thead: Add AON firmware protocol driver
  dt-bindings: power: Add TH1520 SoC power domains
  pmdomain: thead: Add power-domain driver for TH1520
  riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs

 .../bindings/firmware/thead,th1520-aon.yaml   |  53 ++++
 MAINTAINERS                                   |   5 +
 arch/riscv/Kconfig.socs                       |   1 +
 drivers/firmware/Kconfig                      |   9 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/thead,th1520-aon.c           | 247 ++++++++++++++++++
 drivers/pmdomain/Kconfig                      |   1 +
 drivers/pmdomain/Makefile                     |   1 +
 drivers/pmdomain/thead/Kconfig                |  12 +
 drivers/pmdomain/thead/Makefile               |   2 +
 drivers/pmdomain/thead/th1520-pm-domains.c    | 209 +++++++++++++++
 .../dt-bindings/power/thead,th1520-power.h    |  19 ++
 .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
 13 files changed, 760 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 create mode 100644 drivers/firmware/thead,th1520-aon.c
 create mode 100644 drivers/pmdomain/thead/Kconfig
 create mode 100644 drivers/pmdomain/thead/Makefile
 create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
 create mode 100644 include/dt-bindings/power/thead,th1520-power.h
 create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h

-- 
2.34.1


