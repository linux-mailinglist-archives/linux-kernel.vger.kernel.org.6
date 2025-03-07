Return-Path: <linux-kernel+bounces-552019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE2A57419
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F071721DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A8824113D;
	Fri,  7 Mar 2025 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T1SOJPgq"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C12080FD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384545; cv=none; b=N3Cy8sG9Ukz+umZEgQ+pbfIVlXquJofdK7SuoC8eSwXibmBXgza2ophDAIZnqrbk1cNfcp3PnKhgrtv/gZZYAboonQlBl3KTgqIK6bI8PqJcfE/CR8GiJmOFrhYWtg6TTWuMvVn0uavaeCTKHEYL2jBp+q7309cmUOERPpdAJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384545; c=relaxed/simple;
	bh=PQ6a56PJCa6pQaAgDnAv+7bVWUzkRJkT96E2SKdd5Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3X20kGoYnnTwAZ9OC5Iou9IQbDoJTnDjErClyKgvFXDCQ/pXexTw+/zSoSackSpJcXv8b/A4y9E2FeCSW1RWcaNSLhMIn4/fTvgx759yj1V7tCUm0OjbKpd0fK0Rv5QAWTddJekBw9HiDVQgpaKTGyG55OVCDAHq/PYulPVg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T1SOJPgq; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4750ca77d47so20287921cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 13:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741384542; x=1741989342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A3+XzQZr4mJb/ntKs7XgjgPeymgXMMsNQQtuBtbpbmg=;
        b=T1SOJPgq6CvEQx6Vs7D3eytX5wZHpcR6tmUhAtHSCBehLE4emQdUaTsNMePTpDru1Q
         hGdEm5CioWgEnAPo9f0OvB615xsr3KuQqPMadIOP4jGXaZVBP3QuuKwVFGJYWhrvisnf
         rVmtWu+jejkAgcCgFhbuZMG+Bgwrz7zpEIcVjwO2gv83pFAX/NDDIeLEAkkPms1SfwI9
         RjP31VCO/MCaPf7rZt9cHjgJ44/zB85GFTuoCjX9mlDwea0AZs4SUIBTyK3AZb8TNsMe
         IqhefTSfy2ky31/GbX4TNST2Pwpn7Bj/BF4X3JslDWBVQZTYlLnoRE0MOrbtDJKYrAbg
         OuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741384542; x=1741989342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3+XzQZr4mJb/ntKs7XgjgPeymgXMMsNQQtuBtbpbmg=;
        b=EIAqzPE9QmlK5jlFLl3H1rHHZoYOc2VluHJiYaF0cmWBaQt3uRTlwNDnt8HLsUXCuA
         hMnQawePvX25C0q4Qyhi3NJ/rqquih9qDmiMMxtT5/Z7vVm3RaQiR2Sq2geaGXjtgOBD
         l0PHWiwPRTrsFRqaEFVjxZD0H8vst2YcclNh1+ZoWg8zq0UVcey/XoGxxbM2QpprXXHZ
         mwUv9WXQlmBVNeKF04SZI3/MVeJNZce1eXyjjmjh9sIyaTS9/X3EK+mz7UduqHP43ZBG
         7mix1byDH9Pk8y8SlQ2tKyn4p1VdACNLXLstc0x1PG8dxYI+Rz/SMhMbcZNgB40xGCyi
         lbzA==
X-Forwarded-Encrypted: i=1; AJvYcCUeHpX82vWHMOwaaKdAgti3DyGYGywd3QMTuTYEPbLC3obP1WcKVxK9U5jF4ktlT2JGu/tNuOvXPnpRKnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcjx4AyoBg5x0ggGt2bWMSkRzkMes4ilQeEt59Kl3XrJ99AuZR
	jZvboejsUic3y+48kddlgJIr6MX0oXndwxPto/xfiPUoigrF9/CPLVBxrAWMbzA=
X-Gm-Gg: ASbGncv2L0j9Uq3IhRJRpZ/OGF84DpGRo/QYsbbID4xVt1jjghbUeZ6wPZpKSIL5hiS
	snWL8YX0Qy720tieDWvNt2XlKXAd0L1Uf2QiHFicn0CKmqfiBYuCdAc0ef9yzU5m4N8xCbcX9RH
	WPVUdy6E7EJqa3Kr5V/uciZNZp3ouelTVHpKKSewEcBqwktxgvERJe6mpsry37xjTpxI84xDjkU
	9/USNxebJ62tKGsmkOj7zUMPysEQrnir9jU/nzIJkrCVcnQoG6QZAvfWTuBWq4ElEBw2YTMgaQg
	3Uf4AkX4f4/qocglEMBtX/sTEDt5nB83tjHO7FDQTBBxpsfmHOGBBaefh3y0UHgg/TkcBENAFuq
	YLHFlk84ilsPM+Vmnlz/uuavV2P8=
X-Google-Smtp-Source: AGHT+IFAFiDoXNwXc+tdWOD0pr6UvVfYJOgwKNdFxxXHedC/i7pQawo0el20cjHMA8kbOAdFtgIKlg==
X-Received: by 2002:a05:622a:2b0c:b0:476:671e:debc with SMTP id d75a77b69052e-476671ee8c8mr5068191cf.5.1741384542676;
        Fri, 07 Mar 2025 13:55:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751db4fe33sm24424631cf.78.2025.03.07.13.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:55:41 -0800 (PST)
Date: Fri, 7 Mar 2025 16:55:40 -0500
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: Add memory hotplug support in weighted
 interleave
Message-ID: <Z8trXFxJVlYI9LAF@gourry-fedora-PF4VCD3F>
References: <20250307063534.540-1-rakie.kim@sk.com>
 <Z8sXFGBYFlG2Z1s4@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8sXFGBYFlG2Z1s4@gourry-fedora-PF4VCD3F>

On Fri, Mar 07, 2025 at 10:56:04AM -0500, Gregory Price wrote:
> 
> I think the underlying issue you're dealing with is that the system is
> creating more nodes for you than it should.
> 

Looking into this for other reasons, I think you are right that multiple
numa nodes can exist that cover the same memory - just different
regions.

I can see why you would want to hide the nodes that don't actively have
memory online, but i still have concerns for nodes that may come and
go and hiding this configuration from the user until memory arrives.

An example would be a DCD device where a node could add or remove memory
at any time.  If you removed the last block of memory, the node would
disappear - but the block could come back at any time.  That seems
problematic, as you might want to manage that node while no memory is
present.

~Gregory

