Return-Path: <linux-kernel+bounces-545363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76989A4EC0F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573A51882112
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8706327D779;
	Tue,  4 Mar 2025 18:31:43 +0000 (UTC)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD827CCF2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113103; cv=pass; b=cnNb6jlrDCDeUfITu2BK0QGZmVO3uPxWw4fm0oNqyYw/cs8uTk6QAYu5tmJmA/7L3TUlWBH1ksEHA6JtMlQ7yIuetjGrLKavwcNdMJoxt9bdIr/e0v6ZQM7PzrF5gJPLkglGPk5k2EUX+H3InKnogEoI2qbmoR9vkvsw2+rbYgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113103; c=relaxed/simple;
	bh=4wdFl9+UTq4usFH+JTIEK4HYfOFtQJ9UnIDCz0V5EbQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS++g57RKyWLyTegv1HEzYvQcpQcvHKcqlhgBL3Geb9e03Yc5+MCNkhn7zjyb9N2uMELL4bsfTxhHXSEK0JMrjARnSjmI+qaFPAOe5yUAdsuKjlmsEvxmiU/UHhEqRL+1UIhEWAs8t7DFINvtg88bjxbZXvMyQP0v7OFH43p6pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id EDE7B40CFEF8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:31:39 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g8B0l0dzG1Hr
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:48:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 2C1CF400C6; Tue,  4 Mar 2025 18:48:29 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541284-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 950B6437CB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:39:15 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 48C8C3064C0B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:39:15 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91441697A9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493E41F1501;
	Mon,  3 Mar 2025 09:39:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D271D63C0;
	Mon,  3 Mar 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994740; cv=none; b=sUKEwKaCCrR1ZUUNeLFFCMQp4AyuC7XOKZ+AOkYDBFEQmokUfOPxdnS6kLZYplYTI/YEpWwS48GzXxMHFcxN1ybLFGpul3DiKOS6Y0BFgsOOveHcHqvum/adyaOZ+WqkFBNkCNiaCSb+Qp1w5KY2qiKE4KRQ5sQj0KjkicSP1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994740; c=relaxed/simple;
	bh=4wdFl9+UTq4usFH+JTIEK4HYfOFtQJ9UnIDCz0V5EbQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFVdhirBLqGnDnOQVRb2mV3NL1l7KmmOo/1wIKMPWBNhNYdI3FHLf02k5gYdCL2JStoL64lcHHPqy4H2+ryy/6vZp9AcZBCk9V22KVdX/ZCh79X3k2pUeZqqKAWkDo+M+uxrGvaPRMA7YjbLU2Q7XaU4mhKBnVBSAdcLs8O6cII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F7E113E;
	Mon,  3 Mar 2025 01:39:11 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F9C83F66E;
	Mon,  3 Mar 2025 01:38:57 -0800 (PST)
Date: Mon, 3 Mar 2025 09:38:53 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/12] perf script: Refactor branch flags for Arm SPE
Message-ID: <20250303093853.GG2157064@e132581.arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217195908.176207-1-leo.yan@arm.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g8B0l0dzG1Hr
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717790.01703@NnB1epQd4HteUxAintc+NA
X-ITU-MailScanner-SpamCheck: not spam

Hi Arnaldo, Namhyung,

On Mon, Feb 17, 2025 at 07:58:56PM +0000, Leo Yan wrote:
> This patch series refactors branch flags for support Arm SPE.  The patch
> set is divided into two parts, the first part is for refactoring common
> code and the second part is for enabling Arm SPE.

James has given review tags (including the new added patch 06).  Could
you kindly pick up this series?

Sorry for pushing a bit, as we have dependency on it.

Thanks,
Leo


