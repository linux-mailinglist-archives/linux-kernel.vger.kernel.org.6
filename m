Return-Path: <linux-kernel+bounces-346496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813BB98C54C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310D11F25755
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646DC1CCB26;
	Tue,  1 Oct 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="QVz/FYZU"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FE321D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807236; cv=none; b=N2A4DJnU/CWJfufeCb08kYoNsbdgkl6qM2dUYxWQOo+ekTQpPniAFh+9J0hcaTCG/FuUTbigPEt9jarTFy5jygNkyWlv+wL3hAoY0pU3EQEgHqkOFF4ufax6cqxsK/qQBvptXC9Wq3G+E2S87u+8iwkbF5eh9zoQ7bpJLzlZzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807236; c=relaxed/simple;
	bh=x+/oTP1byqCOHysooAL4aCnAxaOcMQUyGMkLvUCrQg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P9Fqls5pqJ3wHVXE3DDYAqMl5Ze73rvgMNYx6j0X0/gQ0CtpbJHTrzsx9ObYRLbE+BAPM7B1sdXBuuVAJk4cLHLS/nRBGNTgSY+VPzckr/kHQw2ipFn6FFOm+coBPWnREluoX0uBUdbn1nXmmux/zHcGf18cJAiAMYFBwIEUbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=QVz/FYZU; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491Fnpag022960;
	Tue, 1 Oct 2024 18:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:mime-version:content-type; s=
	pps0720; bh=x+/oTP1byqCOHysooAL4aCnAxaOcMQUyGMkLvUCrQg0=; b=QVz/
	FYZUZe5uLV/gGcZFOdgtKTMEN2J/CK4lMA29npucclCDFdE/Pobf96eRbIhYDYX8
	m+JB9naTBFOH7t0ChwM8O929QsnE5Bw+q26y4YZJ2dzB5I0adAsPNCwFTwQvRQg0
	0sxhY+z3jxP7SydApugj2nlHKm+uBOnklhqvYnCY47hEUMVMlhq0r33SpV2RiBJE
	o5sXjDoO8p5JYjz/n13NVKSWvlWKuw5T7jE1ylz22NsCJSiqvEI1lv7B9uj5c+sV
	7W9WWQEKbWp9KQmWGnye5rlrvlg8XTGgs61KeV41+RY3N6NIH5JcxavRemtThZcU
	hN1+D/VVpb8VR43s3A==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 420h8fb471-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 18:03:01 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E46ACD29E;
	Tue,  1 Oct 2024 18:02:50 +0000 (UTC)
Received: from DESKTOP-V47QP3F. (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 29AF780C0A6;
	Tue,  1 Oct 2024 18:02:49 +0000 (UTC)
Date: Tue, 1 Oct 2024 13:02:48 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: bp@alien8.de, tony.luck@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] RAS/CEC: Should cec_notifier() set MCE_HANDLED_CEC after a
 soft-offline?
Message-ID: <Zvw5SJQwBB-xo82K@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: THbSvnJew6rQtbqq0OdOrhTVJjpPDCsP
X-Proofpoint-GUID: THbSvnJew6rQtbqq0OdOrhTVJjpPDCsP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 suspectscore=0 mlxlogscore=913 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010116

Hi Boris and Tony,

I noticed CEC should indicate whether it took action to log or handle an error
by setting MCE_HANDLED_CEC (commit 1de08dc) and that EDAC and dev-mcelog should
skip errors that have been processed by CEC (commit 23ba710).

cec_notifier() does not set MCE_HANDLED_CEC when the offlining threshold
is reached in cec_add_elem() because the return code is not zero. Is that
intentional?

Thanks,
Kyle Meyer

