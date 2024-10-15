Return-Path: <linux-kernel+bounces-366789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D6199FA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389CD284C30
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EAA1FDFA5;
	Tue, 15 Oct 2024 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrTvL0Dg"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886821B0F08
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028309; cv=none; b=o35jTZu1wGr5ikAg/KzxJ8vEAdFUvGZmb75XMXDRzb/dryr3mG6z6lttKokRDNcInaHByuOa4XO146HFcmvftB2LiaygxPxb1y8PmjfCij5DWsvtjvTJp+J1E/9r+cOkAYaBmNrlU45A9ET69kFnyMjn0cP2GHBJSBpzAvQhQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028309; c=relaxed/simple;
	bh=HzjDQzMj04wkguHCoDjg6H7HxJYdJ2jX1/fBnJipXRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0LdUce0h/sovV1yQ090miAD/d7Tg1dFOLoH8mC1PBhz7RwYiDoZ3jFd6FRtJifoj3gcERLe7LsyS313Gjll2Arr8Ks+rufxMGzz6t/5Y0p992mkEJInOa5Diu0TShf8lvXG2XqwhZE1924gjiBfZO/sAHjezdzRLS0WFC24H8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrTvL0Dg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cbca51687so32311305ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729028308; x=1729633108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AhpjpBe61RNEZbJYjD51EaXDTChOz8XDZqFL5apPYE=;
        b=SrTvL0Dg40HILO7QAWoHUePKw92Rs73B2oQFHChNC0FgwrbF2hjbQFUdVu0tZ4FQXX
         hTiYjuykWnyd97XuRt95qdPe1jUtWMXs/2JA9umjzCbwjgfYYAInIpBL+7Cc3egQ9sRH
         57kVKAau3RA8Ma9IbRe3r78+rATAqg983cTfY0lhUix+t+03FNgq1QLodzyWu543rj+I
         ImfyriP+GYM8HbWx2jf/YRjCyA4+Zf12MCe99ZyfSR+4WCV9cRkVJiES8Z/47uX2lXBE
         QL1VPDurXduTfks8tJmqjbY4TIrpi+HwsNyoIXQHTlcKhpa4kGmI6D9AIgEbJNSH/kfy
         U/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028308; x=1729633108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AhpjpBe61RNEZbJYjD51EaXDTChOz8XDZqFL5apPYE=;
        b=WhO4siwX8FmFMPXazx0S7xDp4NhagDg7Wr65rjRajEe6oXgfLg2U6AE3sywIilOqu1
         S/LZcjFCbpzHDazf2SDrt/UTkfkVFGssKi+Xr/5CyCbD39SMWWyRSj26dSLhG/tUZA0A
         FvL7YNX8fDBHzR1njBHrDurcRIC1Stc2bEGFCR9RHN6OrJ9SHFhbAG6/uULTsLP/7/WD
         CINK4/dW6sm7w+qaS0xf7fmQ7bBVn9bTANVxiDGsMGFzSvnfbnOmJs9UwbtIhamYp1Jo
         8hH6OlaD9bGDEtbZY/JTZjKYunDPkpYY3CMmPnPffWo70U3EqpzJ8pPXV+YlzzeJq/in
         s2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUqXG6tGusuN0VHsheqO5DX3qf7b1UuxD+ISmL3+wVdJFz36Hqjf13Y5T23xl6o4nO1rd1OkblQM1uhu04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77rZseQnaW3ioQwwZ/l7sSed8AJMHbz+HLS0ca4WjvWYL3FpH
	r2YjnqQlPmiBuXeq7G1HjFfMylmwcHR7FKeDgAkbu/vSi1YqcAd7
X-Google-Smtp-Source: AGHT+IEQs6xsl2HEoYJ2NqDLcqPih/PJJ526xSta+EqFTRGnPxi5jq4xSbKGnW3sYhPcJGUPnlU/mg==
X-Received: by 2002:a17:902:e5cd:b0:20c:8dff:b4ed with SMTP id d9443c01a7336-20cbb1bb3a4mr203705755ad.16.1729028307690;
        Tue, 15 Oct 2024 14:38:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:934d:dff7:4914:60fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f844d5sm16947325ad.31.2024.10.15.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:38:27 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	philipp.g.hortmann@gmail.com,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH 1/2] staging: rtl8723bs: change remaining printk to proper api
Date: Tue, 15 Oct 2024 18:38:22 -0300
Message-Id: <20241015213822.8070-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d20087fc-586e-4a52-99e6-6a09b33ed00e@stanley.mountain>
References: <d20087fc-586e-4a52-99e6-6a09b33ed00e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> No, this isn't right.  You'd need to use a mix of dev_dbg() and pr_cont().
> Basically in drivers it should always be dev_ printks except for pr_cont().

Tks, Dan, for the answer and suggestion. In this case, rather the dev_xxx(),
do you think we can go with netdev_dbg() since this is a network driver and around
the rtw_mlme_ext.c is already being used? (actually, I don't see a direct reference for struct device).
If yes, I would mix the netdev_dbg() and pr_cont().

About [2], it is acceptable to remove the statements like I'm proposing?
Tks and regards.

[2] https://lore.kernel.org/linux-staging/20241015014738.41685-1-rodrigo.gobbi.7@gmail.com/T/#m85d88af4dd8158a8e62ccb6c7257478b7de46d95

