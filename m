Return-Path: <linux-kernel+bounces-387187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103DD9B4D55
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20152852EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86272194123;
	Tue, 29 Oct 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sk/FAPPB"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0A193407
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214901; cv=none; b=DZivpsYkxaOgP6ckXD3Rda0jCcXwZcMhmC1R01Bn7tVjYnvu0ZqDxMBzyJbnZXY/smu9UVMdM+/92++d9ZsARPWMfzxFXXlzOk8kri7389j/tZkqVijmandOJF9l7twmEWjWpi5RRJTbNQUoM9xTFd/MUxgdFRW+i5r5+rowsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214901; c=relaxed/simple;
	bh=WEVAFJYtA9Y8eRxcAvnLv1yBU6QJV9W9DD7V7ombfd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVIEsS7/MQKhwnmXe6IeyCoDKDOjjtyfO7FlIy4/AXsfhdG2uH9Gi9pdAEwrlJTMvHBVe3gq9b65tf2E4LmXcjcG1yFhOhKgIJnDSQ6P0TZl6Z3BD+z+U/MgTNG3WC2wKKH6ljAn8B4Lkk3BipcmN9M80pUzKj69ptls7TMI3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sk/FAPPB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d462c91a9so4009383f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730214897; x=1730819697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEVAFJYtA9Y8eRxcAvnLv1yBU6QJV9W9DD7V7ombfd0=;
        b=sk/FAPPBMcanj6XgUuieuWg508jt0negFuv+PV4bmlG01OBOnPpZQGJlk36qdr7YFr
         0J1/6zO6k86Q+7+hwY7z1DI1qggMXr9yWzSX0GvG9c/e8bDQTbGZmAfMLA0on0Zt6lga
         Ilxmuta3u05IARzoERXiVfiwMgDin20efLFw7Bqjc8PDUlCWBQe+3L929VnYHvzfeFN2
         N5p7ymEoAcZyxLg/AWvYn2MrURs0/J90kQF3l3BYGfxApiUcjTXOU/rVO0ATOW4es2C6
         pVin2cIfpZN6HMMqA9loNJvDTYqvk9u7g/w+Nulsp2mEQcqmZr0q8WLgbKoOD1Y9gK9q
         q+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214897; x=1730819697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEVAFJYtA9Y8eRxcAvnLv1yBU6QJV9W9DD7V7ombfd0=;
        b=JeRX004J1UYZEdLYtibBus3cNfRoEP92s2UwMvm06v/jyZy5tKBxai5zFTog+BoEd4
         QcJ7ORa+wgSkU17BnMaBwAY5baaEldyk5OHxGH0LJZyeaN5pKADLNt2t+VfXncEacJNT
         d0y/nNFOHAjYcz6xRduph3K8Q6xIf7zSmsUysYKnBw3Ast4xmuHwOkrKisbC/6HWbwLe
         Dk56aizgJkJPI5S0XE3HN67OvG1FRVhlE/S1q4DCXcQ+6jbntLDR0m+mMNoa/Ai4+XdB
         4EJzTpUDCB2RF3+5sEAGAq2qqe59JjVseXedu0pb7EZCr43U1tw0O3SSh4C2scx9fpC3
         UzHg==
X-Forwarded-Encrypted: i=1; AJvYcCW3SkFPhLuh1pHO2u2itc2zryUi8gATll8OZJZL6sJ43aIQW6Mdslrun4+RDcyHN9gGE1ZSQaBjJqrENJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTeqn+daLjQadvyp41lmtSr601lR0XF7RXk8EsMHtDQOvK6Nq
	6JsutzkaeoL5P7u064p4EESgWdRDAccvRjtSkzlWTuURrEfI6MtP8bqb8cR2dQ==
X-Google-Smtp-Source: AGHT+IEvPtGdVcRU8TyR3DvwW2u3wVv8xHoeVwhinPnFxDCWGaaWXCPAv9qcGbEX9d4Eegwr9M5sCw==
X-Received: by 2002:a05:6000:118c:b0:374:c4c2:fc23 with SMTP id ffacd0b85a97d-381b710f70bmr1760f8f.56.1730214897028;
        Tue, 29 Oct 2024 08:14:57 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b71479sm12702220f8f.69.2024.10.29.08.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:14:56 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:14:53 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
Message-ID: <ZyD77Y8bIP3JCAZE@google.com>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
 <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>
 <ZyDlAd-Z26wnhZK5@google.com>
 <da230ccf-37b6-4e43-be12-9035c594e535@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da230ccf-37b6-4e43-be12-9035c594e535@sirena.org.uk>

On Tue, Oct 29, 2024 at 02:08:32PM +0000, Mark Brown wrote:
> That doesn't seem to have shown up here?

Sorry for the mix up, I've accidentally replied in the wrong thread.
As I said in https://lore.kernel.org/all/ZyDndtgj5vKo-wvB@google.com/:

> Actually, my reply above meant to be for the nl80211 fix
> (https://lore.kernel.org/r/20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com).

> For this fix I couldn't send v2, because it has been already applied by
> Mark Brown. Guess I would need to send a separate message to the stable
> team asking them to pick this patch from git.

Cheers
--
Aleksei Vetrov

