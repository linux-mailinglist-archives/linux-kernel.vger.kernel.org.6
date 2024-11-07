Return-Path: <linux-kernel+bounces-400516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819619C0EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462DD282008
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100CA217453;
	Thu,  7 Nov 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="k3wi30cQ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC90216E1B;
	Thu,  7 Nov 2024 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006768; cv=none; b=fjs9MrzmBj3eRzjXJJr4GI26AaAuWpupPAJmwwDAjm+XY7yJVlyfWYs8C7BInzqQuTKFIvu25sQPK9VdQyy1GwsWmVmibZnEziJ7wUBlyohnXRfRLb38WGSUaeknFpvJ6P3g5FItYbAO5AIHdGjK7UV0pCbf6nN2YU35ld04czA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006768; c=relaxed/simple;
	bh=qbJ7A8tmzlCsiZME3aYRFEdaDPxTi9F6+GUrzy4EAew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ANXXwzZUwwaFQvY10A/19/MwMRnvH4NY+NfCJSeW/H0DCSMcqvhLMolKZSoQW6d3tF26QEwrcIoQJ/l0BP1UL7oO40XHRzNhG/Ow74+x4W6AF8XLB3YwMItiLzR9iZPeKG5UNRlgJfkLyjvY1+YhwKnGJXLiZlpndFfAyBUrgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=k3wi30cQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8A76B42C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731006765; bh=6qDaekR3ixvknUE5hLqzx4OWjsh8x+XE97H00iggpu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k3wi30cQOtxflMv6UoWvuiX9Vx8SImwAiihcH43nmZqCgXJHPRMK1Gj5LCq5KZ1ZI
	 lAs55HuEMqV5GXcjhUwoglMjYfJ2wYNOVrJrhWQjwpCtk1EKUc9bZQkHZeBwYOu3cg
	 SezA7MimqKMj60tmzoMhYAHV27Qh9vmuUAU9bAsIn+jr1wc+v5SQiUl+cHrRHPSQl2
	 Nzzv6ja4KV+1ry17oxMfO4DO4ruVPvi71kiJMEzr9Ri0h2YgPO5Qs83FZhbgWtk4YU
	 /tQ6+aaC02P6PRFZuWhrWB8O4selXHlZZe3hhOGSFyh6QUJ4y3L0LbluVJOMBAJtbF
	 zVlNdoQqFvMAg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8A76B42C17;
	Thu,  7 Nov 2024 19:12:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] drivers: core: Clarify EPROBE_DEFER retry mechanism
In-Reply-To: <CABCoZhAK7wTrUFouz306QJ_i1ytgo6cLEKemc_5qhez6Wo-1Zg@mail.gmail.com>
References: <20241105045535.84071-1-yesanishhere@gmail.com>
 <CABCoZhAK7wTrUFouz306QJ_i1ytgo6cLEKemc_5qhez6Wo-1Zg@mail.gmail.com>
Date: Thu, 07 Nov 2024 12:12:44 -0700
Message-ID: <87pln626z7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

anish kumar <yesanishhere@gmail.com> writes:

> Hello Jonathan,
>
> Wondering if you have any comments?

It has been three days - and not the nicest days at that.  Please be
more patient.

jon

