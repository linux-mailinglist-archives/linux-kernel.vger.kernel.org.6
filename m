Return-Path: <linux-kernel+bounces-260335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AFD93A77B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC81281A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491E713D8A6;
	Tue, 23 Jul 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="euWl0Vrr"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614613C8EE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760866; cv=none; b=UKRjcE4dWP7RycrPP6VBrh4uJgnboIytCzv97l+Kk0ruvlF0lR0fsdT9o2QOA2zfIzq/FaecU7NrzdNscZkKye6FhLW1d+YCkusXk1vxoaeGRhoqo144eHEGVzQ1cKkPHExXNLAeaMyEugsO6AsXHQ4eCBLvjsl9phLacK4CDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760866; c=relaxed/simple;
	bh=hBGmJFGudBcu7tftLyopZNa5ZHDvY0w16iin1mnABWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYluA7A6SXxZx5Xf6xqDbrLeob0cqDtoOVcwzpyuPGJOCemzq6GwsSXk8LqoLGAjBYihVeq896xZCjFnKzSA9megvAIU2bFA+JDJ8PXKIJh3pULYSOIu6aV1zyxZIZ4GLyMig2Er8bF4Co4/EnDIUJcTBiclXCbvfs8bRhUSAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=euWl0Vrr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so5281902a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721760862; x=1722365662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o1PzO6HxZpKiR7Rz2aR5/ziuFXny/LO3qCWA5hi2tjQ=;
        b=euWl0VrrWVyH9nailACpreqfyg2EtN9kGJoux2sRqQriqJPbocUGLwo9M2Bet3BBfJ
         6D/8gZ+RwXgma2vmHFtsvwUIcCp7+1CpN9fLpsO4po8pMRY8dAnqqeJlgOtM+TxYV6Xw
         cULO3UqO+RzhnkpIgVRhnFu3yI9NRKk7xfHH6qHEb130+WqGWWNXqKShqZ2S8NNAj0TD
         fA3xau+hLjytAT6eY8X6GB1aeToIs8YpBJrSiJohnv2MqZYIQJOgto7sH37Ql12xnvwf
         sWbscSVB+8CpD33UfhLNxb0GZJs1WZhL90M9fpjAQCIQYhUjr7zcUeXLkJ2AakUvP1XZ
         6zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721760862; x=1722365662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1PzO6HxZpKiR7Rz2aR5/ziuFXny/LO3qCWA5hi2tjQ=;
        b=YMgj0Dw6ztQLqePsfaIDXwIQDWrkq+3w5jcoRz5yCc21OFX6Vq+62XNS3DC+hQK2US
         Y/dQ1vJ5FMmceTq1y1hlRkJsVuX6/ByKy18k0FSLkU3w0d8DNBAs3om1Pb2DfqHW87CH
         Nsxycp5QdvN0avXd7NPn3SpWdbgAuIFo5BVgA5o/0ZnO4Rv/YvNYWIZzZBc7nozWVf4m
         2jViCRrLxUHa/y851uBm/pGRJYN9gwpXuqYa6vSxnWtU3DyNRmQf5hLkdiIBsdSR6/l6
         9udO79CILDQjpXPfI9nQHtlksuiacop0wwlwwmi2anVKec1QCZLfANAH4dBTtEqNd4dU
         Xkhg==
X-Forwarded-Encrypted: i=1; AJvYcCVvNIzZ4LFlMsK90mj93K8g568mS9/c1bl7nDxP2p70J8WYzsDsKeYSQ0yXiqGwJ+eJuYN0UJCX6IPebOUbR0RVCGDKL15RHdOALEIy
X-Gm-Message-State: AOJu0YyM/OjuRw7bmRmViPyEhTcUenM+tieX4Bwm3Qeuj9sJjOxiGfAg
	tWt5sg6SVm9fl7N5a3QzBmptTCN9q+zV890DQ6sLM+XjxfYOxRYoPb6NcaVbjbE=
X-Google-Smtp-Source: AGHT+IFFlsbMiKpNZ6xTNTBTADEM6hScRq6FGfi8gHejzlkOcm3NDKRROYEkjF7TpTio3aaJeIWo1w==
X-Received: by 2002:a17:907:d24:b0:a77:dbe2:31ff with SMTP id a640c23a62f3a-a7aabca8c83mr33269866b.66.1721760861984;
        Tue, 23 Jul 2024 11:54:21 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a953dec17sm104856066b.44.2024.07.23.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:54:21 -0700 (PDT)
Date: Tue, 23 Jul 2024 20:54:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, maz@kernel.org, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Align kvrealloc() with krealloc()
Message-ID: <Zp_8XVdxHLtf203L@tiehlicka>
References: <20240722163111.4766-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722163111.4766-1-dakr@kernel.org>

To both patches:
Acked-by: Michal Hocko <mhocko@suse.com>

Sorry, I was a bit dense today.

-- 
Michal Hocko
SUSE Labs

