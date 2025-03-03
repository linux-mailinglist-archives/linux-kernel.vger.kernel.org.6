Return-Path: <linux-kernel+bounces-541864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED104A4C2A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73731667B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC8212FB3;
	Mon,  3 Mar 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMfGrQ0M"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508121128D;
	Mon,  3 Mar 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010358; cv=none; b=a7pR0DH7lSRdI4zcl6+qFWDSjsAKr7RTR133SYRlQMAWNvOlpY0QrO+ajQDX9dy/mEvqK0WiTtEPY8fbEuSP98lX9jnPI+YjphHN++zzYbCZnejOB+YSceSk2bgHPmg4mQ/eU5mHjobqwXKcWJ8zU8Wcanr+URLOvS8cpt9uQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010358; c=relaxed/simple;
	bh=aCzck+5umm89xbCr5uf7I4rMYXSf8aGHLei86MNCb04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzQMx1VeGeQCh2cs/9OhpiEJCXeJnvXVOERdK+XyhkkVVWEYOBc4XvIE2izC4Wt4TCTdwbs4OF/8m3i00iDNnyk4AC6Zqii3H4xxITZPn5iIYzZ5+GeLObsTJFUXV9JRzSxrkDuWjsagSFSNTBn9i3/nNIhnMG6f/IOPxPtTlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMfGrQ0M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22328dca22fso66525815ad.1;
        Mon, 03 Mar 2025 05:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010355; x=1741615155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWzcrOwXdymJD531/VeFi+cXBZlpa2+kaaFzyIB35Ik=;
        b=HMfGrQ0MEL8EpQHoTIkMt/UV//5Re5Swdfpt+9UtQT5dWalG9gSgjdVEGWcGjXhQlN
         EBKFNSyHH4ogwRIly+MKCIPA2mtiSkP1jjjYK7jWNNPv4JPXcDc4+eh7NQEMSu46WPMb
         0TyXd80HyAdPq9Lx0QynMfQYDJZ3sHbX3bKLtYEV2E4xUXs1c5omEiiX8X6wJjbJM7Ta
         Q/HGPp6Yh0UGZmAOUeAxjIL8yglU1Ohq1bVIAoqFhU/TWPDHPZhljW17wxjwyRdjwshi
         w6U6b6g4dnQRfL4Y7KI/5GY1AI1wk6yHeVCN2vaa3feJFd23aDpHaOIuWoeOFrOcvkYq
         cZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010355; x=1741615155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWzcrOwXdymJD531/VeFi+cXBZlpa2+kaaFzyIB35Ik=;
        b=Yoz50h7mwRLWa9jCLGGqHqMk14yiqZyVj0iEnSU7P+kH1WWW29IuEqYvDJbW3R/EbP
         twHuJPKpR/AUm9zK/LNHPt6pVeTAG5CCsx/DKtb1SI5m7D4IuaBc4XVhhru3QBwO3Tgi
         RV6ao07PHQ7WrBvwbp++QkylGYapvJxrsGSe9wTZpVG+aQTksZiIQwM6MYskQ19ZAvhR
         DRJiq4V5utQNo5JEuiHxML0REFM+pT7gukFjFK7Y3YpjfNTcPmKPB0mFefB3ATGr+DnM
         M7rn21copFhJQbRoZNyG3F1YSbanP4sI6b8dk16Z9gI13ws1Lju7gI0yTNZySEsKjMbF
         vJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCWL6K3on9fNOUSOGZc5TS//865vBwNx6U2xMI5uZFHCeGvTu2b7RVrA8kZLNRH5GPFwztjjrz1C7n0Sb+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNp4x5Ibk0vJxazl5mxb6pGFhRN1kIWekU4ncDI8orq6XvocJ
	cyZlqoqjUqYmzRC2wyKXHo9yK2bkc49t86pPBFc1SVabNxCMDaWW9zjAiQ==
X-Gm-Gg: ASbGncutN8hwsj6OZLGUzfsSUj+zv2nMWWnhpTp6EgXNoukaBeQ4WpQWo969aLeCgQB
	6S7zUfSVeHrD972BXxoNRzgvlXZqhEG6gA4IN2bwoustZlSlk3h3QTt+kG1LaQJ2V3nrJBjmZPU
	C8r+kzKxJM/8Tax7/lEX7YIsavmgYbZdQBX3cLDZnhYr2Tt1hMlHbplI/8AZmtWX985Dh81MLZj
	nYADxz5JG1GbDQad5FkKrjbG8W/bWW7uCoFaRw8w34RVwqagFHyK9IrRCF7/NLp59jX6hg5i7Gb
	G5cB4Axbkm/VYsa52sxgM608MJ9d/CcZA29LjmvXY/8pGO+GbISQczt44w==
X-Google-Smtp-Source: AGHT+IG7Z0nVXtNXCNE3Kj6/NMwSc1HiU62F92nPIsV8Hqt67/S2rnqaIHmgye6z+lvMLC2uRXPQDg==
X-Received: by 2002:a17:902:ec90:b0:223:628c:199 with SMTP id d9443c01a7336-2236926725amr177548805ad.52.1741010355266;
        Mon, 03 Mar 2025 05:59:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fd28dsm78064945ad.94.2025.03.03.05.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:59:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 3 Mar 2025 05:59:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, arnd@arndb.de, shyam-sundar.s-k@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v5 01/11] hwmon/misc: amd-sbi: Move core sbrmi from hwmon
 to misc
Message-ID: <4a1ba8b2-5d95-4eae-b7a5-cafaf6228817@roeck-us.net>
References: <20250303105902.215009-1-akshay.gupta@amd.com>
 <20250303105902.215009-2-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303105902.215009-2-akshay.gupta@amd.com>

On Mon, Mar 03, 2025 at 10:58:52AM +0000, Akshay Gupta wrote:
> This is done to support other functionality provided by the SBRMI, which
> does not fit in the hwmon subsystem.
> 
> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

