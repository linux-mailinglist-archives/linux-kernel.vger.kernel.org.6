Return-Path: <linux-kernel+bounces-267172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8325F940DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3478B1F2595F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8E194A64;
	Tue, 30 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ts2tuZ69"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007D18EFE0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332254; cv=none; b=KKAbHNZnDi0wAd6ziQQNngPVRDRqVl+a6MusLMurF9Y960xxcNasuESDSM00AYEObK4KGK/7NmJD7qzNY7stEbBqjcOnlyZIgFPnZYUv7L7cvgQIXM3+5+13uYvFAETpqFDt2ehP7ngTDEI3m/3djgi6YQQX4y2dknjqDsVZS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332254; c=relaxed/simple;
	bh=KdGmcfWsGgK6bxUKWDKS/68k1bwlHb0FpLwZMSYvVhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFa8Y99mZ1ID8jBgIvHx4Adsf+xgOGUH+xeml4ITpcm67v2TT9FyjjjD+FYikVM/TwT3h9GOvLy3eipijqpBLs/jOLg5MFKrF19p5TBp6xJS6ricuiaiHTC57tMOPL5X61g+JhXPMO0G9b1jDoZF6kSD3KSbpQIPFRMLyk8e3LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ts2tuZ69; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d19c525b5so2782853b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722332252; x=1722937052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RE4xuFaK7o1VdMlUMGMW+rvJdvw//aVlSwKfiTd7RwU=;
        b=Ts2tuZ69LTSywNJi0LQSe8xM0GNrt9c27yx2sz1x0vYAdGjiFfcf/aofx2qAfzGNU+
         psO1eikMUa70CDj/iKOjDu2d9LJ4YJMgNr68pZeXTdHVNwPoWmTnJ3IdA8uOOsGZjXhL
         uWPOszLmUyIV7/+hV552WraxINM5uXB5IVpxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332252; x=1722937052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE4xuFaK7o1VdMlUMGMW+rvJdvw//aVlSwKfiTd7RwU=;
        b=a8Ykd1UW/S4eBBmoolc/1/Mw4vU78rNOEcYjzn/+wkVCDNPOkABrUoW0IA4WYjs6sJ
         tD9i7Ho4xJN67nC0ectT7wZOM2AVu9iqAabAluLeuMJqBwzC/OaYXJsl/HZCgTBJnTbY
         leLfpATbOuG1GSDbai21bngcbkttbVWgcbuUWI32Df1v1VDW8C3F5W/sgA2pn/NsTzPE
         8b1x3A7TI9Ut26+XONjrlOWk/6xRYW6DRhXzcKxqn9FkIuQmjcos/0OX/H1MZvdj5PLf
         Td8JL6SeoxVITujYP0KnFlUg6BbTCcBJf3tzeN+9FYWRXZlthvXGmEMvT3JX+jIHfZia
         o5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBGCmZEyeztj6Ypxr4AG0G1rhNuGG8fqqPAB52AYDRjXCmT9RgnHv6whEgbfS1vcs5uRB6SW4bS/6v0+Iv1cDlCMNhY6AB99ASqAaS
X-Gm-Message-State: AOJu0Yy3f4qRh2MLj9lJ2HgYlmyxJYOJc8XKSkoaEpzghl8Di2qtFtBz
	0dVLxCE6VsqX5axuem9iXU3TScEIpAUaAmB+dk3BVaD+WJel+rXPuItScK096A==
X-Google-Smtp-Source: AGHT+IFoNVpjI2QFtcIdO/JlLAoeftomtDmKnBuC7QVyCDD3ATxThG4RpoGQpbPio5SM9vduJRmZyQ==
X-Received: by 2002:a05:6a21:9cca:b0:1c4:c297:3d3f with SMTP id adf61e73a8af0-1c4c297409dmr5543112637.32.1722332251976;
        Tue, 30 Jul 2024 02:37:31 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a51d:b844:f0ff:3c91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a5ffasm8049613b3a.216.2024.07.30.02.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:37:31 -0700 (PDT)
Date: Tue, 30 Jul 2024 18:37:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v4 22/22] mm/zsmalloc: update comments for page->zpdesc
 changes
Message-ID: <20240730093726.GB16599@google.com>
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-23-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112534.3416707-23-alexs@kernel.org>

On (24/07/29 19:25), alexs@kernel.org wrote:
> 
> From: Alex Shi <alexs@kernel.org>
> 

Usually some simple commit message is still expected.

