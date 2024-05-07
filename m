Return-Path: <linux-kernel+bounces-171882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBA8BE9E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF481C20C0A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9051010;
	Tue,  7 May 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SaB/dUvU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mwy6h6t9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEB2D796
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100978; cv=none; b=u+iOpKLk3KxwfekfpFbxSJZf0EkCTEQRTFGMdEx4W6/nKFuR+uH2eLW6oNvPGKgaZSYErmdjy2PM4OdiIjBJRXtBWy7rjcT4l3PO0G+tpDpa07AN0qyJg2nM0Qf/iOYeWsTpBNj3zJvIx+J1MYgvVFJeNd1o0tRyspO4lgEAjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100978; c=relaxed/simple;
	bh=/vp/CQjOYf7JCHPphR5N9cL7ULbA5LmpzRMUWUt5pDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elrxOaGT3fE02uN9m6ut9g08+USMGRh0+dHa0VccSqkteNn3XtiMQFHBRiqiFj4Dj5f5GjkxS/nYpfacx+I5Ph4QYp1AN8W5gyzSv2YUcAc2u33FMpYFk4eXOm2vYTxdTGszmJGyUEr7ykqhwmrOOCaqjaCdh/02/OWk5zraHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SaB/dUvU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mwy6h6t9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715100975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vp/CQjOYf7JCHPphR5N9cL7ULbA5LmpzRMUWUt5pDM=;
	b=SaB/dUvUyV4FlaHX1YThsXlm0PyFeacR/Nvrf67PiOVgihBCcFc34VPe3BLhpmtCT/cfnm
	/KJpVxS8h03E++4Qne07VAbX3DcfgYJBT6ocdKPmTtZA7BbFKQ2JP6ISsI8b0aoropb9I3
	31YlbcMSkptSIf9gTkKfP1ObW0rbSIi2XF5AOnlgDBpmkpc2fOq3CtxZ0UMiy6m+vqyjqP
	ZN0ZheUzlplnNDgv+MUiFAtTVfdgr1VUDRiONl3m6EIcpUTg4DT+SbCd4lrsBKHaoNSF4j
	PugQB5iS3iLLN9nOdAUUs8gXqZjC08Htazb45Gn4sZi28CKiIPLW7SyuQdhaYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715100975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vp/CQjOYf7JCHPphR5N9cL7ULbA5LmpzRMUWUt5pDM=;
	b=mwy6h6t9XmmYWXI6eiA1YsRf9dC9Jrck1XyMmv+6Ok4wOrEruTdt342U9ygD6Rbdj1zyHi
	RUjSKlS36RBCI6CA==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: Re: [PATCH v3 4/4] selftests/mm: Add new testcases for pkeys
In-Reply-To: <875xvprfnm.ffs@tglx>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-5-aruna.ramakrishna@oracle.com>
 <875xvprfnm.ffs@tglx>
Date: Tue, 07 May 2024 18:56:15 +0200
Message-ID: <87ttj9pnm8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 07 2024 at 14:05, Thomas Gleixner wrote:
> On Thu, Apr 25 2024 at 18:05, Aruna Ramakrishna wrote:
>> especially with pkey 0 disabled.
>>
>> Signed-off-by: Keith Lucas <keith.lucas@oracle.com>
>> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>

Forgot to mention that this Signed-off-by chain is invalid.

