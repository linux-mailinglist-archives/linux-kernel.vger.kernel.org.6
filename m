Return-Path: <linux-kernel+bounces-244703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 281CE92A81C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F191F21B80
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF9C14A08D;
	Mon,  8 Jul 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5AME/I6"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124F81751
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458768; cv=none; b=c2IuVi6UR91KAhSYgkqy0YXOpzPe1ZPa1GfeBzAVsXmlmAfI6vuPnq+CVYP0ezHwoFZQ785s2nCmR+oQvMj11hy+lLkugv987DDBdJMPgWhliIQ5V3MqmaK6tqATm68lYOqGEPobzlA7Ycp/L5d9fgq+4ms06OarcYZxSM4KyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458768; c=relaxed/simple;
	bh=FSZowTiHHR086TOD1V2AHR4FZ9TOUyVbCKoQI61eks0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1XI6GZykFCcMX2yehMFwhMeIOuMGFrd4cTzYSbI3gq0XK1QFnPzCWISAvmsNgpT9rVEqfBS4lghCbAQyYbdppz0LtrtkdZq2Iz7RkVjJeG82UqQl8jTjhVINTUKz4KAja/8y+7Y8QwwBBAn+LY9zrFiJgKO9y3+8WrrPJ2GCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5AME/I6; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-375af3538f2so18251315ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720458766; x=1721063566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mx10B1dlf0nDqTxOJR8GqKC+ICenZNRBy4aC5Tbp6MA=;
        b=j5AME/I6veqVn65eFNnMepBaYPGEtFGfiWLUr8tNu3XmO7qIfaBKlYODPMoX5gl8GW
         cDJFqDxI39pqsQj9vrmhEHAr0ZfBdSv2rWY7Kdk6rjNFsNxECTieNXaFRwZuKeOQ87ZH
         ZxPXPlf4xdhzBitE5JJk5s4XnDpBBqJHoDNJq5xpH57f7dxanxpRg7NAkKkpz1LUHYR1
         V35cM0/d4UqQU7nklkqyOzLx8elFeXhpU07K98+T/bv4PEv6Ioo9LwKFpPsKcaXZl832
         z95mfqlBU0H/j5dEX5/ANdAe15Y/KL3Rfe8vk1QRFn/+KThu+oQlrCiTTsXbNfANEypF
         E1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720458766; x=1721063566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx10B1dlf0nDqTxOJR8GqKC+ICenZNRBy4aC5Tbp6MA=;
        b=j3VJ/6XDv7DSiqokWU6QkoLLXsrpg38qoKKYAkmbgnRL7qGOspCzCKmrEzUE+KJQ28
         0iIb6QCkWQb7cAyzywwiLrB/bFh1VyyAcG7M9bXAzs2rBQDoPt8HtmZlXHVKA1Ye4yNq
         kr+ZCzQk2l+rdbgl2gWHnY2P3nJzI5v893IQSuns0xwD5AgwMDElfuYgQavdLFxLpVi3
         vmeRP2M57pMZUtG0HLPIE0jlNafOL/YfRIRixPCOHGYAkgXup9aHMcYuQTNrBoKiauHi
         /FkoJmlDzc041AOfH973zVQ7ptoqRGdQxQmWhKln8zt4OPRjLGL6BwKoQcpx75BdRhV3
         jZ1w==
X-Gm-Message-State: AOJu0YxC+GbTTApe+DqN8OaTcCCECUDICZ6FBiwC3YucejXUvBqYy56l
	jLdE1RS7zXQBgqVwoThOtKM7QkKDuMr3Q0lF9KpR7nLsEfy33cOlvAwRYw==
X-Google-Smtp-Source: AGHT+IHszQtugxvFyPbUqk3LQ4hlgAqyM5BiiqIW/cqxtEeSLXezknJBbfhIX35/I1S8JVEDhk2Szg==
X-Received: by 2002:a05:6e02:1aad:b0:382:fae5:16cf with SMTP id e9e14a558f8ab-38a57214070mr2032455ab.5.1720458766107;
        Mon, 08 Jul 2024 10:12:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d682b4611sm104145a12.84.2024.07.08.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:12:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 07:12:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/ext: Add BPF function to fetch rq
Message-ID: <ZoweDMHAqRLwB3kZ@slm.duckdns.org>
References: <7359b5cd17d56837bc15f4883b21837163c51d37.1720441953.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7359b5cd17d56837bc15f4883b21837163c51d37.1720441953.git.hongyan.xia2@arm.com>

Hello,

On Mon, Jul 08, 2024 at 03:01:18PM +0100, Hongyan Xia wrote:
> rq contains many useful fields to implement a custom scheduler. For
> example, various clock signals like clock_task and clock_pelt can be
> used to track load. It also contains stats in other sched_classes, which
> are useful to drive scheduling decisions in ext.
> 
> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>

Applied to sched_ext/for-6.11. I moved the new helper below
scx_bpf_task_cpu() as that's the block for more generic accessors.

Thanks.

-- 
tejun

