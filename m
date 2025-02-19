Return-Path: <linux-kernel+bounces-522173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5F1A3C700
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56283AA96A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01055214A6D;
	Wed, 19 Feb 2025 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd/obWM7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4D214819
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988360; cv=none; b=EtxOUlIPHMhLvGUXwMmYVZeCoNw75asAVDhdLKxan6y5fJJoZ75S+JBIu+g2lReQ0/nzun6WPYib91+dRI3TU/VhC4/9BZGTVfbMLeYuWSfhKoeLFcquGYo1eNt3+qZcJ3UtdUoJDO8FcTUyTY+xE1xk/2QD2g905sVkhBJXhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988360; c=relaxed/simple;
	bh=R15E9b7EgxG8lvqI4p1hlUMjMyrN/t+YN4MZxXgBlLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hsyftx7RllQmjmD3VKQ5k7YlKrJahvfSSSgjhhZSKFBBsfElNCKZa6iOfI2ibVzDGBQjpm/qhL3N1e1Jyycig326DzuQZcdsZW+tdQhZiIUS0HOcbwrFDPCQ2vtQ2idlRVw9/rTQoIIiAwt4Ixftj46RpmsDeNcX2J5HwVernKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd/obWM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF10DC4CED1;
	Wed, 19 Feb 2025 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988359;
	bh=R15E9b7EgxG8lvqI4p1hlUMjMyrN/t+YN4MZxXgBlLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rd/obWM7S65TaNeVPJnl7xzEj2AggFx+mTAs/Hwc/i3B6dkQ3xLg7cqO6fdkqk4Bc
	 ZKd2xn4b6tkZQnX+ErImhEpCncSZyKybDDk7hUNCA3xDEy3pWo9F386EuWFknneoJQ
	 wLk4Zv2/vjk003PFr+BsLFKBVz5AmFh4ga/0aT4u5vdOwG6o06LjlHFJCOaRj4Jkfe
	 d3SIVjBm9LVmquODwu6rusXnPuGobCIt32pJZs3a7HLgk+jpqX+bMDJZ010kd9jyHS
	 E8Mwd652nqVSDJ1m/cu1QANCfGQElTkj5E/TdOeEa/RJXVt+PTQlKWpNS7f6Axw881
	 Osvvrd4H53pdQ==
Date: Wed, 19 Feb 2025 10:05:56 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 07/10] x86/ibt: Add paranoid FineIBT mode
Message-ID: <202502191005.11B95F4CB8@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163515.040300905@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163515.040300905@infradead.org>

On Wed, Feb 19, 2025 at 05:21:14PM +0100, Peter Zijlstra wrote:
> Due to concerns about circumvention attacks against FineIBT on 'naked'
> ENDBR, add an additional caller side hash check to FineIBT. This
> should make it impossible to pivot over such a 'naked' ENDBR
> instruction at the cost of an additional load.
> 
> The specific pivot reported was against the SYSCALL entry site and
> FRED will have all those holes fixed up.
> 
> This specific fineibt_paranoid_start[] sequence was concocted by
> Scott.
> 
> Reported-by: Jennifer Miller <jmill@asu.edu>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

With patch 6's misplaced chunk moved, looks good:

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

