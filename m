Return-Path: <linux-kernel+bounces-299380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2B995D3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56ABC1F23CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2CF18F2CB;
	Fri, 23 Aug 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="CTh6LX8v"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954318E74C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432059; cv=none; b=VjZwQgX6qYZPo5phKudt63nN1u5MpLeNS1HwcmGKK4cdAlbYhr0eOdBClFcXyVBfereAfc4xNgnRCtxFe16+1egcKZ2hGU7j926ITOq/4fmj5zxYlmq5HXOItPO+d8plsVw+awVl+mJwt1oAAfWU8vNRpNVkv3iJnExMVl4U5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432059; c=relaxed/simple;
	bh=yLM8J7H2DsgRDxPVtS0CcqhN2nJId985NbMPevWwKAk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NzBMoZlVBjmy2CPI97XZgVJGlSJfFP/pOs3Oa4xjFfAhAd08qo40pOolAOoSPjVnLFxErrlnzHq5lWl1JyLlI+9nZmk2t1HizlQKrox/CzEWG50Vcx1nyqcMyBAH+Opyjea9LhPoFuE4Di62zvET4hJGQG2qxGgxR28yfCxaQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=CTh6LX8v; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e164caa76e4so2011051276.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724432057; x=1725036857; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLM8J7H2DsgRDxPVtS0CcqhN2nJId985NbMPevWwKAk=;
        b=CTh6LX8vfmq70xS2bf5iF08XblWbEXQl1P/S89D6K28fHKuGHn3tYHVHfxW+Y0Vqu3
         zgyxaPXJTRDPhEm0I6gaBqjhUOYzCR8u3sdAbnK2d9C2lYwTan+Ng1iHyGUUJZR6+0Tl
         QAP8nck6XZ2DHbb1R2UaSf7GlTkr8DNpa0qvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432057; x=1725036857;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLM8J7H2DsgRDxPVtS0CcqhN2nJId985NbMPevWwKAk=;
        b=WNDlct6ytUzVoJExpSK5GGJpC1+ymOIi+iXUx/7IZSSQGsJnH58VqVH8YGVq6kjzb7
         NTEGx3EkNUJJRp6aeaqomIe3AYCD5M00/MJ8jx1AzD7NR7HKu5f8oB7ngSaTI51X3Bjl
         2LhjhgV3zKWcNEGzHQmIEn8RzgJZGwhJMGB4rJUMpzSeALSBFWYng7liRDetdhjlyd9O
         ieTShtBOGhJ3spN98mSSvFw4KWdEuxnaCM5hmoaIDcUpb+ReyEOn0K5xJQf/WCi3JmUN
         ruKTkV0DlAmaDgmZ/avz6Z7Gj50LWovTxJ/uNvmhwyL7Tz/p/We5cglkUsxBeShNfUD8
         QD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy5foM2DzZ2wIyBxxYQK4+0XLTkqADPtOoY848uICXpm+PpewOAJHUjto2ABn/73xdzax2faAnJhL2YFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztnegjOhRyaPPN8C8cJ53pYG/Uk1KMeOkDU3ZqXwSXZH8yOQEv
	N28dJgga67QDyTDSQru1ffrYpbyPKT2dKYLSbsH9ybjJREXDWZaF15h70Y2xOo8=
X-Google-Smtp-Source: AGHT+IH+lZIalG0ZppdDUStKyMfxmA2xRM0YnXPLiu2xPW0X1PX57ufunWwRCXTvVh1qWh0OpYdpBw==
X-Received: by 2002:a05:6902:2383:b0:e0b:e4ce:9047 with SMTP id 3f1490d57ef6-e17a83de244mr3495755276.18.1724432055984;
        Fri, 23 Aug 2024 09:54:15 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4406b0sm720032276.12.2024.08.23.09.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:54:15 -0700 (PDT)
Message-ID: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
Date: Fri, 23 Aug 2024 11:54:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: eli@mellanox.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, kvm@vger.kernel.org,
 eperezma@redhat.com, sashal@kernel.org, yuehaibing@huawei.com,
 steven.sistare@oracle.com
From: Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [RFC] Why is set_config not supported in mlx5_vnet?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I'm debugging my vDPA setup, and when using ioctl to retrieve the
configuration, I noticed that it's running in half duplex mode:

Configuration data (24 bytes):
  MAC address: (Mac address)
  Status: 0x0001
  Max virtqueue pairs: 8
  MTU: 1500
  Speed: 0 Mb
  Duplex: Half Duplex
  RSS max key size: 0
  RSS max indirection table length: 0
  Supported hash types: 0x00000000

I believe this might be contributing to the underperformance of vDPA. While
looking into how to change this option for Mellanox, I read the following
kernel code in mlx5_vnet.c:

static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
                 unsigned int len)
{
    /* not supported */
}

I was wondering why this is the case. Is there another way for me to change
these configuration settings?

Thank you in advance,
Carlos


