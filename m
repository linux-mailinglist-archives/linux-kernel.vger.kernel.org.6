Return-Path: <linux-kernel+bounces-545815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB4A4F1D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535B2188B247
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E639263C91;
	Tue,  4 Mar 2025 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xy+/xgCF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA0BA2D;
	Tue,  4 Mar 2025 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132487; cv=none; b=KNt6ssxApyXs+mfOrGTxfk3gl/upP4JvOSgd6YKkLTzcJvL3Y1PNcsyxdWhnl4TUzSGuvmbtEdPJQjq53LVM44XUVhYNhS9Y0hT46Uvg8uwirspxhwMOBEReypSsQ5VQdhV+Gdjnzj5+m/R7uMj9DYuOFwNI5LAciOJvE67tmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132487; c=relaxed/simple;
	bh=JdEdu8rWm4LE7G5ugiUzr9rqHea6qEYMUFmgEv8icac=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JGxPqKdGw4xWk/LdWcqv/V/ivkHZ4n/6aDfmTo9lW3CcQ7xsZLwrt5SADqBy8AVqoAXivZDSb2o2aaWAijN0zLlz7koAOcO7Hi+Hygn0jMO/7RbQMSHWnWPO5bEp4OS8Xa49xFX0qDQNnC+tkiR8uUZkUMtCf/Byyt36GKaTycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xy+/xgCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8225C4CEE5;
	Tue,  4 Mar 2025 23:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741132487;
	bh=JdEdu8rWm4LE7G5ugiUzr9rqHea6qEYMUFmgEv8icac=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=xy+/xgCFuxJ96sdso8AR6Gyg8pT3QxCChvG+rlLcjSLS69cjxXRELarOkPJy3y5Hf
	 4iMLA4C3CT3yfMhV+B6fFr6WzhdSHObnX7haQsIaAPYGtM0iK4+KS6kYNrikrQ73VT
	 wqYc4BoAFj+ovbK0Oa2jkBKWZxi/yekMDoaR+QRY=
Date: Tue, 4 Mar 2025 15:54:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov"
 <kirill@shutemov.name>, ebiederm@xmission.com, kexec@lists.infradead.org,
 Yan Zhao <yan.y.zhao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-Id: <20250304155446.c87d23fb763e606e05344e4c@linux-foundation.org>
In-Reply-To: <20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
	<xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
	<Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
	<20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
	<20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 15:53:27 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> Yan, please go back through the discussion and incorporate reviewer
> feedback into the changelogs: describe the possible issues which people
> have raised and your responses to those.  Then resend and then let us
> restart the review process.  With less reviewer latency please!

Meanwhile, I'll add this old patch to mm.git to get some testing coverage.

