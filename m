Return-Path: <linux-kernel+bounces-546000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA291A4F504
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CC2164C82
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CEC156F44;
	Wed,  5 Mar 2025 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qHAlah7c"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70D13F43A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143582; cv=none; b=APtYSg/TNXW+F+Q+Y/tqtlZb4Iq+nY5Ak6kDgiduxxGBZGtgxLnaXusmCnCkgIJcNv/vinQjaK4H9eQ3ucBp1S9c6pH/EPhro4C8hXrszjmoKPRvdsNzVQzBbzeX4zJj/fgNgLdPSWHuIDMJ40J1deHywW2q0ln/WHHCBBMPd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143582; c=relaxed/simple;
	bh=PCNzOrZ6fFHbZFlpkP/J9R0cTPAHndmjskgnEeXZdu0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FAhi3/t8ehUwXFMZJVKTgGG98Lqro77bL6E+01zFuaLgswYhGFJrGTvyq/GMAN2AyoP2idOUNmVPGtWgGzd51WIYQ70fQEFIjvNB4bVhrTx+TlpC8nKEcuBAFqG7bwE0oADArWnqQ2baLdVz6jjFTHIOd/2E46uIJTwcr55J1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qHAlah7c; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741143577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZUD9FHcJZMRi3hr6Ln+x8h4/Fn+HQN5iiqIcRwcYIk=;
	b=qHAlah7c6HYkboSWz6seWxBu15uRDhQ/OHZkb82vNp7rN6n51Himjf/ZmWCZg8ES+Nqqvf
	NBqk+9wLogJtBpRzkuH66vlwpHA60/rgf9Kk6SBEwBKQv7Miwf0+Q8mNxmunSIzu7YtLrZ
	HHE0cZKOfHqJbKIOGYiqtUYGrDDlDAk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] xfs: Replace deprecated strncpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250305022153.GC2803771@frogsfrogsfrogs>
Date: Wed, 5 Mar 2025 03:59:24 +0100
Cc: Carlos Maiolino <cem@kernel.org>,
 linux-hardening@vger.kernel.org,
 linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C7A61D9B-F2C2-41A2-968E-0E6A937140D9@linux.dev>
References: <20250305011020.160220-2-thorsten.blum@linux.dev>
 <20250305022153.GC2803771@frogsfrogsfrogs>
To: "Darrick J. Wong" <djwong@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 5. Mar 2025, at 03:21, Darrick J. Wong wrote:
> On Wed, Mar 05, 2025 at 02:10:21AM +0100, Thorsten Blum wrote:
>> strncpy() is deprecated for NUL-terminated destination buffers. Use
>> strscpy() instead and remove the manual NUL-termination.
>> 
>> No functional changes intended.
>> 
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> Please read the list archives before you post:
> https://lore.kernel.org/linux-xfs/20230211050641.GA2118932@ceph-admin/

My bad, I found [1] and saw that you reviewed it, but missed Li's reply.

[1] https://lore.kernel.org/linux-kernel/Y9sKXhxvf0DDusih@magnolia/
[2] https://lore.kernel.org/linux-xfs/20230211050641.GA2118932@ceph-admin/


