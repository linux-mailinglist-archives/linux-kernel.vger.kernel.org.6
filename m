Return-Path: <linux-kernel+bounces-272298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D589459CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08D21C22942
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D921BF33D;
	Fri,  2 Aug 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q1uOcXmU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CNdNCScV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC31494DE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586948; cv=none; b=dtZ0ZFM/icyvK2x4jMvITUAHkwAVulAm10vCO8CwxwGbiYArMvXf/fjzdkDJ6AkI0fl6bS1LOXSFw07JfEosS9nMKAqt9To8JhEmsFKiZU0bxlSlDbwzAISfh27+IjBx3IJ9XSUzfEXmOx7HqwDUVXTT5V6c5y03VI0I1Vw296E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586948; c=relaxed/simple;
	bh=pzimt/9MBCN8azyxhMdkRPjEi2v6pkUcSpRbvXIV+1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4qBRRojWC0YD64goVvdoLZSwuJRyf+lwmu51Mz4QB1nQfdLx7VL6GcNOxKVCZ5EZ9U5Q1cmqunWTyXGWcuUViZKyrKWodmLFWKIDT/GGK9K2YY76JlR6nGP8P2HWgNaYcVPB7DSOK2cgAi1+H5NA+7/MhaPztqhUKizxqXV2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q1uOcXmU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CNdNCScV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722586944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69gs3blZoT1306kf5AjWiNpS1u+Pu4rBAwPi+uq79ws=;
	b=q1uOcXmU1XbaHH2CVmtwBCB5eLW1YgVgF48tKovgtjEPVrbmLZYWAILMWdwrSG3zQP+AQ7
	fvJkDGn2uLc+9rQD7R5gmjgvV4SAiFXP0OL8PlyO1SrO/OJj+D7SZP99uYWXqkeLIfiaYy
	wPiEFf06gkJwT+tyM0cXeA11ZOMsp3gVt35dlI6YJRGqO/v1NNkNfzG+D7/Pwt65LeEOm2
	28Mn4CPbvCrBrhyrfQ0A/hdXPxvhCnMgaZPpOhtQox/VIi/Myv9cfWMYxjsC7MBQFBxr3B
	v53vkBagdpVpEajQVgCyh+mxEIxFFHEhnlf9JVYgx8wpDVEKIcYbun3vvsh4Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722586944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69gs3blZoT1306kf5AjWiNpS1u+Pu4rBAwPi+uq79ws=;
	b=CNdNCScVlXeKnfNPSpDkRptI7V8o9b5k6Fkc6/kf/IdxHChXYmc4OPkzrxPuit+n1NN5Ox
	rcTmHCcNF4Bzx8Ag==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 linux-mm@kvack.org, keith.lucas@oracle.com, jeffxu@chromium.org,
 rick.p.edgecombe@intel.com, jorgelo@chromium.org, keescook@chromium.org,
 sroettger@google.com, jannh@google.com, aruna.ramakrishna@oracle.com
Subject: Re: [PATCH v8 5/5] selftests/mm: Add new testcases for pkeys
In-Reply-To: <20240802061318.2140081-6-aruna.ramakrishna@oracle.com>
References: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com>
 <20240802061318.2140081-6-aruna.ramakrishna@oracle.com>
Date: Fri, 02 Aug 2024 10:22:23 +0200
Message-ID: <87v80j1ghs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 02 2024 at 06:13, Aruna Ramakrishna wrote:
>  
> -__attribute__((noinline)) int read_ptr(int *ptr);
> +noinline int read_ptr(int *ptr)

tools/include only defines noinline for gcc, so a clang build won't have
it ...

Sigh...

