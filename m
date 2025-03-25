Return-Path: <linux-kernel+bounces-575923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C1A708EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61E43A7819
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A2195980;
	Tue, 25 Mar 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cAhb6xx5"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC8176AB5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926686; cv=none; b=A3a1YreSNz++EyvM7a9SI6ME72Sro2G5mXIZypgUjenQkzzKi/sys8kQSabwPXlH8bfspH5OJB/ntBuYF7g4O4OOvlEKGsYQA5K7usrK5a31ardxVtmzlWYTcynBCnYsb40kdzLO6dJRLHwH0G0BUCndrOaiBHlBoQIUzloL75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926686; c=relaxed/simple;
	bh=/4+bLAd5YIoSfto7uBkSvM5inHnQsWrkg2NKoQTN1ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJi17HgYcSqw/qz/Rwk48AQgm8LLhUQ6Ou/5hbzV+oQVBLZePTlEjg0aZ7SCoQ8pbO5dN70U1YJ01T2BMuMnf+oAm18ya2HpyhoRYioo/B7riij7sChFZXuwDcSvqhKqIrocX6lS+s8Yk2pZV93zSESsCSa5CQKztxwey3QHQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cAhb6xx5; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b43b60b6bso3843439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742926684; x=1743531484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4+bLAd5YIoSfto7uBkSvM5inHnQsWrkg2NKoQTN1ps=;
        b=cAhb6xx5/FqYSdd/1pORUOfxDXuZwjI1+wO/qNjf+5iOaxo5aH6OrERWlUwDuyLJxz
         VKCHKuRLynpMWRS0zezpKRoORVHrqW/R7Y+YDgw9karI/FqV/q15HB11/8XpAn9SK2bP
         m/NPF0zyV73OYAN0tWiQJvRCSrf0Jgqrziu9qNDjPz9ss1hTIqsnRx4tw97dZBol3kiv
         57gmth1WbMErq9QcPwMjCvFiiXaQqgKUpbMzBgdUhs8E6H3UdfuQrape7k5yPTaGJ4Ky
         5IQiS22e7hQsHmDDGnP30mYfnghmmT46fk28Bnrtzo154xFqt15ve1u4/V2wMI10bh3N
         jvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926684; x=1743531484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4+bLAd5YIoSfto7uBkSvM5inHnQsWrkg2NKoQTN1ps=;
        b=M6PWb/qYv1eTSG6TdROepoyeiu5lfn6bZIc85wWtfmRnSAnCsPo+U8LegEm1N2UDXt
         2dDWBcg8GLGPGdZ7xBAz+ied7J/mFTlOd1we6HF/NLeQ4nmeQN07VWbf7URU7DfeokPY
         a42NVYKDvIKg2O7Fd6Qa9uqToSNk/3EX13PbPyp83hMgOLS9mbZ1UcyDf1Mcj1goAoBf
         UnNQMNKTq73POaM3B8fXsh5u9oQDsNGu30HwfeYNN2psPEsLIxVGcaqeRHOf5zA3zjmm
         QHMcDRxOgkY6Xd/KPo9ntd+EexJkyphpcsgumussl+QhAgwPWPVDvC8z8Dabwi/+3k5+
         Vouw==
X-Forwarded-Encrypted: i=1; AJvYcCVP6ULdD7NA3rQfWMWR/mprcyNKS3K0EOLKgJ/J5tEE+xHpoGe9kV1cKh91/WinMr1Eab1v3CwnGCBI+e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfviZ11tkiDb/kEpDI/1zoIwyRnK/jWB5AOpQQURh+8BIUL1lB
	JdXTOGUJrr1JduBwgHT7dCU4uvm7+gMdAE7lsVZ5s5YDz03P8JEETgzRY5EpQS8=
X-Gm-Gg: ASbGnctd7pP8Zin09WFhVdm2i+yyq1UYApZR9uHLsOowols1E8oMHJcVxlZs4pFQRPv
	FuUs9xgc7G9c9b5/oP9u4SmDZXBxflUyBX9XGGKcnHceJRggaQ40o5G3gJV5hLHpHneAiLpQE/8
	umLpBmfyzlflKoxEewFbaNpc6Q57swK1I+GhHafj04jSwoUjFCbvtoKQAfhtfXmdeupeGp0ly+w
	0xHcyobSu0dr+ItrRYEkgTe2mBt91lEBjvT9b4Bd2X4xpri7EJotb94nBBDm/2Fylet4AY4LOc4
	PGkWIKGy2D84tV7Q+JJvR7BfyA==
X-Google-Smtp-Source: AGHT+IHerZJCcUba5+2uQMpJ6FxRljVNwdYl2gum46dsHYwuSY7HzXegJqiAeVDE22k7LOpkVelMjg==
X-Received: by 2002:a05:6602:b8f:b0:85b:36cc:201b with SMTP id ca18e2360f4ac-85e751c2403mr101382339f.2.1742926683683;
        Tue, 25 Mar 2025 11:18:03 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc13d74sm217164439f.11.2025.03.25.11.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:18:03 -0700 (PDT)
Date: Tue, 25 Mar 2025 13:18:00 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-integrity@vger.kernel.org,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudfalre.com
Subject: Re: [PATCH] ima: process_measurement() needlessly takes inode_lock()
 on MAY_READ
Message-ID: <Z-LzWCbROAI2H2Dx@CMGLRV3>
References: <20250325181616.79540-2-fred@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325181616.79540-2-fred@cloudflare.com>

My mistake, this is PATCH v2. I forgot to change the subject in git
send-email. I can resend if that's needed.


