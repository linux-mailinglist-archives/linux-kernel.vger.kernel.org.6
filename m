Return-Path: <linux-kernel+bounces-394983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA109BB6DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2532820E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCDB13B797;
	Mon,  4 Nov 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hv7h3cjF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79212DD8A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728613; cv=none; b=KAmvI7S1wpjiRit3da09JKN75pqkVGvz7YPp4dIsQxZWlBLNkZo95yTGWvcpQYxuokGXkjd4K0igs1EjPx0d/M+ip83rc4SHdR+gYtYqda7QBM2w3xz0vYUlTFmO1qTCnmVmU9rIGNH4a5uGZbA76JreI1HNAi389cdSLa5fyIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728613; c=relaxed/simple;
	bh=WdKSOwkN/bOae/okVujhYJk8LYHuMtI0ie1V/+WX+l0=;
	h=Message-Id:Date:From:To:Cc:Subject; b=WP9aCf7v9HvzxpF1uMbXi49X9+9KMfohEZDfEqvs06ygtNbG/1dDfaCtz/JR7Yg2lhiQeROxZ/kaZNrjxQWjCPDNP+3TySbytmmRL8g1AxPpEsa4CDGEyDSkK/+E8Xlu3QysqZ6ZIJrtH3IstOnhAKeo2lImUnwSaVfoFx0xyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hv7h3cjF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WdKSOwkN/bOae/okVujhYJk8LYHuMtI0ie1V/+WX+l0=; b=hv7h3cjF8wAf7uUZGLlYJ95mOt
	HV3j+NQ9vD13LRgtAWz/9rjzraUCo9CfOP3I2L3Z7SSftu3Jm9JDoptWYJxW4/rS3M7xQe+IDfstg
	XfX2u7j3HEVI2f+QrpH/iYE6zl+6USwMAL2sxZ6Oxa53/EZGBd6eYWgkprp2vepk7L4/5MFkhbYSV
	llflTAaWzyRUGYCwww+GQcOAr+tvH2QAJkdSpraGj2BtabQWiHGSALq2WckReLPxynywBqrVczj12
	qnGeprgc/CQ/POpPRiscTx2E2KRXUy6/oIuehlO+hRm7Oa2A8unZz8UgsSJL9uHAKEQW+k6e2urHk
	dKZt+6BQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-0000000BL7y-1Q6H;
	Mon, 04 Nov 2024 13:56:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 4C58430042E; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104133909.669111662@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 willy@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH 00/19] perf: Make perf_pmu_unregister() usable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

Lucas convinced me that perf_pmu_unregister() is a trainwreck; after
considering a few options I was like, how hard could it be..

So find here a few patches that clean things up in preparation and then a final
patch that makes unregistering a PMU work by introducing a new event state
(REVOKED) and ensuring that any event in such a state will never get to using
it's PMU methods ever again.



