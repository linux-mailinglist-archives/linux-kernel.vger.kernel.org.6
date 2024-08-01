Return-Path: <linux-kernel+bounces-271908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433D89454D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2816B22E62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3014D44E;
	Thu,  1 Aug 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLKRhYKt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980F745F2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722554052; cv=none; b=b2dsbk4ZdA/wtG9/9//Fu8kZx4QswZ2c48zNJ5Vwq5DVq5D3QQs/w15PXFZbWDNvGAPlhIC7oLsEvDje5emFdnZCkQRFVglE7OP52qQk0NyZxQxw5ku4JJSFlV29yVoR048LPePvLqp98tj2KQu1b4i9GR5yMlTJwzx/bAtBCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722554052; c=relaxed/simple;
	bh=MpZ8YFLAos7lcCCHj0r+kbws7Yr4ZsS6a007Uq2OCeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1GgSCYl0Hkrr5rysdcCobzvBSZvfWzyf7NsAw6iBBIeFTXQIDYq9OQwHm7lgMKe3PNbMejoPXKBqHGOpzm9pJmsxTqIR16scKLMALIXHKbKCCo6eNwbHquj1C2lWrROeupPQfC830L+Cw1yycgoTnF5FciiEXS/oP8biWTa9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLKRhYKt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd9e70b592so54076985ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722554050; x=1723158850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qz7rULbE/YQ4fZI4jymhxxPeeJNrZPu2ymRl2uHo/WY=;
        b=BLKRhYKtID68V7TntrZAvjVa4d11d2CPM63z4llaDA8OYS/UBYBJqMXCNtK4ExqEQa
         TrWLK0vlHXm0d6qziADnuxcRBOFynI2EQ1Qc26wIhDSo9PxKHJ8+opwffFwThLbV3HVK
         J9O2CCS+M4MIxwL4Fmlv36rxs2y26RF1fiX50di1+9G1l06Cwi9awnDNNVtw4VWHtL1k
         kg+WefUjrwcvxwqLptstXqOQfM6IkOuEQcP6Oxu+NONtxq4pIKjbf5/w+HhzZPigmHAK
         sF4a1hWXHyG0n+jqIMqlS1KSlLt/lFigWCs1Ry+V1WBAApR826VJJogd1/LUbl6WftJ9
         CgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722554050; x=1723158850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz7rULbE/YQ4fZI4jymhxxPeeJNrZPu2ymRl2uHo/WY=;
        b=ch0C0V3mzd6DlEPdFSA4DfyQmfnWUOPpndeONU5+2PhC1tgExDijmalttHvlDf87qQ
         VNQJmA/OEchpD+pqIRIqgVVDKFYEDUyZaWKEzQgGhfrSS5gbcUwFIkmUQ4LEUCbU8DVH
         FrNZmWetsSHQex90SaoxC70COMewCmteVQgBr+i8qT3DKjOHqw0M32MeBYkyspNh23YC
         nF0PSROsdIM1mkSTLilCF29GsWJsqDFglAT0td6jhpu/WLyCdFIcrRzp1Q9xIhgNiZ1b
         w888VgXZa4r59saawOXkvw1ClTEf2Y9tjbF239OqlPEcduetPdcLxqCFqCTVpX7qH7pk
         +hTw==
X-Gm-Message-State: AOJu0Yz9OxKEyUfRtyBTY6ohPIoVkfSPEPE7XZvGdzrUbuVX7PgWU0CA
	PfV1fSvMMg7LOMpcnfaMYEihCtJAlwH7Pk4KedUVb3A1X3b027sk
X-Google-Smtp-Source: AGHT+IGhZxPYZmKIdO/XwLvyLxbuXH7QdNsu+z2QXPhszitJ+j5YImoMJLQKEczY0o0sTYTJXVoU2w==
X-Received: by 2002:a17:903:190:b0:1fd:82ac:7c39 with SMTP id d9443c01a7336-1ff5742185bmr20989405ad.41.1722554049951;
        Thu, 01 Aug 2024 16:14:09 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5917a5f4sm4315045ad.211.2024.08.01.16.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 16:14:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 1 Aug 2024 13:14:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH] workqueue: Remove incorrect
 "WARN_ON_ONCE(!list_empty(&worker->entry));" from dying worker
Message-ID: <ZqwWwEtak1IC4Us6@slm.duckdns.org>
References: <20240725010437.694727-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725010437.694727-1-jiangshanlai@gmail.com>

On Thu, Jul 25, 2024 at 09:04:37AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> The commit 68f83057b913 ("workqueue: Reap workers via kthread_stop()
> and remove detach_completion") changes the procedure of destroying
> workers; the dying workers are kept in the cull_list in wake_dying_workers()
> with the pool lock held and removed from the cull_list by the newly
> added reap_dying_workers() without the pool lock.
> 
> This can cause a warning if the dying worker is wokenup earlier than
> reaped as reported by Marc:

Applied to wq/for-6.11-fixes.

Thanks.

-- 
tejun

