Return-Path: <linux-kernel+bounces-239703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A740A926434
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535BE1F23341
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945DC17D892;
	Wed,  3 Jul 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R09PnS3k"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9817967F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018976; cv=none; b=VazTznGOs6dGeAlKEljVwSppqpeRBnGL7hLLKBhnBw8XlgQ+jajSY+olOdvP5+7Iyih8tvkkgJFmB17x577JVgt5rgDs4urUOOhT21B6mw0sUzedJL+bsg29Gh5v2XdsQREcGSw/qNGHEVJOceJ08s3qABE9NoklMyDlD4FLNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018976; c=relaxed/simple;
	bh=5POAQwxlEVLJLSFij3brRfCbCM8gcvTvJetfnuYqgXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFJNxZ0lWXK/kMSYrl+Qv5CG6HRkin5RyTlSgidIWk1WGKL9NVzQj9CDcabdJvDbs9lRcTfYxfy0NtSfr7S5NnNXcc2ipt2AGjA7tkaEiycLkuwkb2v39ZRAZfjw17/5A7cFx+XuZ6cuft7hCgnAVrVWZpYoVBZPbU17sxU1N38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R09PnS3k; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: youling.tang@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720018970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20ySm3U3S1LiU3m2Re7JW0Tn2z5nTSYsCoeIly2B2rk=;
	b=R09PnS3kMyIoOr4s7X4fnq6FBpzQ4zBMrLjAXO2Kg/0XrsYy/+OcvuMWndrqVELXrz9k+u
	aIrHVNrEK+AmFMUkQqUf/jpWehGraZ8IdXsqs32VbHS+t58qH9uao3VhQP6q6XWJoCF293
	omAcj6l9pt1oWwrlF0PBoMW/76oZe7Y=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
Date: Wed, 3 Jul 2024 11:02:46 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] bcachefs: Mark bch_inode_info as SLAB_ACCOUNT
Message-ID: <32comcbsxjfut3pw3jx4jlzeqarcqvy5267k7qbqlgwmfrmp7e@f3ufymzk2a2h>
References: <20240703070955.104163-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703070955.104163-1-youling.tang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 03, 2024 at 03:09:55PM GMT, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> After commit 230e9fc28604 ("slab: add SLAB_ACCOUNT flag"), we need to mark
> the inode cache as SLAB_ACCOUNT, similar to commit 5d097056c9a0 ("kmemcg:
> account for certain kmem allocations to memcg")
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
 
 Thanks, applied

