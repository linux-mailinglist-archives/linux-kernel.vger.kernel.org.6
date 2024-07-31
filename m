Return-Path: <linux-kernel+bounces-269811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5416D943713
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0906A2828C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DCD1607B6;
	Wed, 31 Jul 2024 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvQonstc"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16B1BDCF;
	Wed, 31 Jul 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457639; cv=none; b=GuZ7nEJTnlPdQchLAQrReaaFAPTagOrOSbuMSQh/CCh3edvm2zyJUz4gptQ8xKrRacN1u+xI2/CCdJmwqDqJHGXfM/uLCjvYD0rQdQPdJj6LEhOqjT8C17AqSpECG93hHBfOwijCFd1BVFEeyL6+0V6SurFUKYRrKdu4hS6uWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457639; c=relaxed/simple;
	bh=zB0axP2F77ORQxg1pjxCBKiivu46Q/Vh86in4O39YWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVtr1zwr0dL2OxRheZ9BtLBgO3lpuDIZiFvCzqUIDabHLhOxDacyJbxQjoGjJhZatmG+Ct8BXihHK2Fxre4zKrZzkpDRee/KGDrddDZaupa+YKl2o8vzcjtHlL+nXvwDak1D+s0Nb+RWXM4E0UEbpsFYujG/shT7YArfEVLVLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvQonstc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6bce380eb96so3757021a12.0;
        Wed, 31 Jul 2024 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722457637; x=1723062437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTovI5tyaMnlfhhgK1XxTvqFkA90Kgrc7qBLm2IKffc=;
        b=OvQonstcdG58kywEDSww3bpSh0HaB1UbIxORVWXAS4RM+pUF3bf5un24fZV20DFSR4
         EqgcOhoeXR5NyjaKM/UU77SN46wUdHnR855gQHhhak3MbrNEDxMAlKqQly3KPFZ0Eory
         ZibKcJHDcF74Ca+/g+wk1Lf386zT8zoYVHz3SERI9jzFRXSFg8t/DGsTxv0sUhPk6lm3
         ZRorBp3UvDD2pJz84sHaKSfAjQPQEHhoqqVVB4DZdEseGfabjd/5C0rUiIu0qsfmybsF
         SalaL/UYtZqPgbvzl5JM1B2dN5htyI/o2LxgFNmQRdeSByqthJ8DVfKT/m7ijzHROXSO
         FUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722457637; x=1723062437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTovI5tyaMnlfhhgK1XxTvqFkA90Kgrc7qBLm2IKffc=;
        b=COBIofG+qJI2LQ+x7b4NvhCMGEH43SCRM9DrBqwyLucE4T/k45oaan3S/gA5F5PPtq
         bXpU0kS8sPs7PXoLagrolGSyuNMScET0CKZphqhe0FtHQiNhCnTaigQgYlIRloSxy8St
         z0MG+2Z2RX4QCL2LQhjnbkpQlJa3QUExHJi0EX9jXCbEqZfGKaaJokRP5J90co7o8rXH
         r2odqUmZeCkJgQ8gBWQXxBzARLI/PapD07aAvoL58IWmrDFlSdTv65oVJ1jFmNuMOqB8
         qEkRXR52kx/1rXE1R8482AwIu4NQ+NCqUKwZfpEQ8OMo4uIn1a205WFgk6f7TbkK8GG5
         R52Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPHTGYwc0UR7bdxFv2QmatW7lC3IKhVAscNWszRUvM17YJO3z5umkN6SA1WyF8OTlTolMk3ADb2TVLubEngrSBPb2IKh/qdWB2ITGGClUdZnL0vhY7I78QTsH4x1LHrLfFiM1qJO4Q4Xs=
X-Gm-Message-State: AOJu0YwOeVfRHhqyoUoMITtc1cDgh8QATPIjSmFDGrkNfMXnbSJ0Tm2h
	1Erak/7xikqAAZDSfj5sZP9NbIpKHWuUnv2it5/WKBsncMh/6CMo
X-Google-Smtp-Source: AGHT+IHO6yQaH/+oW9EIfebRBH1rw/LlqkMRxIM/gRNKuhGBdxHEJfhUnqEPmj2QB9C5x8u1Xt86ZQ==
X-Received: by 2002:a17:90a:6882:b0:2c9:9658:d704 with SMTP id 98e67ed59e1d1-2cfe7b4c376mr431388a91.40.1722457636725;
        Wed, 31 Jul 2024 13:27:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4a8185sm1784722a91.39.2024.07.31.13.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:27:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Jul 2024 13:27:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: vexpress: Use of_property_present()
Message-ID: <1f50fda1-d70c-4f96-86b2-d078790a8efd@roeck-us.net>
References: <20240731191312.1710417-13-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731191312.1710417-13-robh@kernel.org>

On Wed, Jul 31, 2024 at 01:12:51PM -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied.

Thanks,
Guenter

