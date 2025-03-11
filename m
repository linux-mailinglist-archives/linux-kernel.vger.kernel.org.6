Return-Path: <linux-kernel+bounces-557062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21FA5D321
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E587189B721
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E3230D0D;
	Tue, 11 Mar 2025 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ6w6IaR"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D951D6DBB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735598; cv=none; b=LXoPWoBFv8wBiS9IbB7Qhjr8F6fNC/2gn+RNx6K/7dYsCD44XHHzgLt0xlQk4mHT8chbm7Is5XFHNGAwSbkN0BG/ObYB6ZQf0r2ivB8UAUDHizN86g/BIg8cR5C1ZuP8skMUBZq6gSLeGr2SpDFsxts5qEp1BnkAgMeHdHV/160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735598; c=relaxed/simple;
	bh=NB9hHXv5biXAPCwiGO2RzmRPnzHDPQYRuFhlhDx477U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPEVij8zomsB+tzPOPPF624XNeuf515t/ijxtlFP8kg+vyTis+HndMuscfbCue/3lRSOlybowB5i4YFa4zfXZ1DbmcY9mIy4rFHZU7EBfDtnTz/MQg2OTphdoYJjfwqPI/jF+YDBMb23fPhq1HFZPYCZeMxRfsY6+8nFLAP/fQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ6w6IaR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so564966a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741735597; x=1742340397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB9hHXv5biXAPCwiGO2RzmRPnzHDPQYRuFhlhDx477U=;
        b=CQ6w6IaRCthZh+FQwpVRZR8OwrcpjgBusZIlwvMSQbHOVQOn/+OHLlcAmH1khQ+h/w
         ksSHA7orEqp/2MTzl9p4mfT6GlPsfc3GKLUkgbhDCwXVf9IhfHHL51kamjlQRMx/ByDo
         x6bUYu+ucUdyx+JwVhGOoZQMyYiQLskSYKGwXHcCDjnrs49jsNEVbJlj2gA9yrm4hPlr
         r7R1aJi0rwk7UqdR6IgbaMo8wQKUAFxOeu4h0vkvog//baKIHzhRIJmUlp9lmicQtTFT
         moxENub/h2tD6a6oBbUgJZ3zLm7CcflLWyEzsZSEPIHReymFrzutUHBNMxAz2mEEZtfI
         GTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741735597; x=1742340397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NB9hHXv5biXAPCwiGO2RzmRPnzHDPQYRuFhlhDx477U=;
        b=RDh7qiOec9Hh6DsPaPVMxfrlPSqaB0QuyRPSKCPNYZZ7YCmy/c1lkM940oFGD1gA/u
         3ieiaQ5NiX36Z9scBLVjyGnVQvHWd4dVmBzRS7xJTya7GlS4mFAgMZoKaJTEIJ7G9IIr
         3ljNaE7L6R7ciLzAE/aA+9W3Gph1Ko0jYveJAwRzJgIIO3LOaV9KJrgmiRUNtimMJcCU
         LGjLpOmEoIOXmVPAG+26prTJLkQuQAe05qfyiQa9Oe8qU4mIAWd8HAn4/Lgwv/c0OSj4
         CM1UR95psr/lARY9mxEG0Rfms+SSGHKQ/GMhIO5kPQspUIotyDNOZY95hneW3veF4dZb
         NfFg==
X-Forwarded-Encrypted: i=1; AJvYcCUN+N2AA1K1GXp/Fd9yYSuPtPTxl8q5GWzf7tENoM8gECNLxyj7BMBlruFpQnFv0XICGYJDsgB2tMoo7HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeO4FOxHCyNm68yjzcQBPWMPDJm+0qrEU/BYxChWwNbj6GIgtU
	cgmio0k8o2thZTHreQ4NvZCsfzRmVI6SWhwoe1MeGwrQ8vpAlnWV
X-Gm-Gg: ASbGnctoszZqcWjL2/Vjvj26WLxRYwjXXH2npWqEPY2QHJDCKsGl4+kw3WTZbBriGq7
	yvH1jBHDum9ylI8sTNww73LpaFiGIFbGFpRNPqNbIYGepSAAMUFzzIhWmzrAkVSVNhTwQGiux8v
	rPz3Rv9LQr4gcw9rkQx5DVI/6kfZF6PkYCw6dDRR7c2h6iuMRkhsyForyiD48K/oQkiXg9F0TfQ
	ZjxRDoMd+rDj2+NyR48xi+9itMOlnQGa52Ro/GiXt6E0IsYA+ZR+HXSnCzIYthG3iyjGEDfpLBl
	5qGSbgRG6P24zA/8FDSsvjC9iilXSbXUz/A4v8YqVOJT0eFmj4eWhu6l+n3hrG1TrYU=
X-Google-Smtp-Source: AGHT+IHiNhkuocGL2i51iwpj3PetKDkdPdrWYI8h4KDdGMoprBvmAaPCtkiCwsr2Pc2nOtnFOwQg/g==
X-Received: by 2002:a17:90b:5403:b0:2fa:1e56:5d82 with SMTP id 98e67ed59e1d1-301005782bbmr6800630a91.17.1741735596542;
        Tue, 11 Mar 2025 16:26:36 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4ff:1626:32b1:712a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddc89sm104040225ad.36.2025.03.11.16.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 16:26:36 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	dpenkler@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2] staging: gpib: change return type of t1_delay function to report errors
Date: Tue, 11 Mar 2025 20:25:56 -0300
Message-ID: <20250311232625.4983-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2025021915-scandal-hypnoses-cad7@gregkh>
References: <2025021915-scandal-hypnoses-cad7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can you rebase against my latest staging-testing branch, as this no
> longer applies there due to other changes that were sent before yours.

Yes, I've submitted a v3 at [1].
Tks for pointing that, now it should work, regards!

[1] https://lore.kernel.org/linux-staging/20250225014811.77995-1-rodrigo.gobbi.7@gmail.com/T/#u

