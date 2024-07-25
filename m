Return-Path: <linux-kernel+bounces-262489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5FA93C7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72DC284595
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4619DF8D;
	Thu, 25 Jul 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bQyZcsbf"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF717588
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928301; cv=none; b=hPTAIbOcLIWSRq36+UARswJjt0BBLSl1f2XioCtQ+tG5nIWn0J8xdQB3Pt20vOC/O6m+b7Y6vLpW8bhrclFv4Iv78J2ytbaHFCnBcN3eqBy1UpKyYtW6X9pZ2NEYMFoigOs0oJHGlPhgyN7pEk5GO1RKFE57U6KY0d65YJ/DlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928301; c=relaxed/simple;
	bh=Xiu5K1l+G5yDdAgnFQDu+MxO88zQNvs6lad/Mc4lTS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEl4orzRyc+xGPtN4KQBCiw7953o1M/EJ5jB2I0dngYci7qInu9+OWaEGosuOl/B+78XjzVL4jYmJ6HYpfUi4OqcLpoJPeHT+zB80uFQBsIrxtxNDfraJvUrn7fuUlj8hiCbY7i5sgZahqOiZ452HjLkG3Z7yUxWlVZwj9iK69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bQyZcsbf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d2b27c115so82465b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721928299; x=1722533099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xiu5K1l+G5yDdAgnFQDu+MxO88zQNvs6lad/Mc4lTS0=;
        b=bQyZcsbfPTGD/80bikWSkUMG7f+Fdmr2oF59WD1BmGRL+ayY/1/qf+J6dEryCeQva2
         2lq8Lx+3x3p5ltpyVQZOfVRKSNsw7Mp2OsJ6MOtvVfPlER//s7yyNWjDzpw8JE9Anw7P
         LXq+px4GP5dShKDDp/TxcO62c/7HMLnttYJ3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721928299; x=1722533099;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xiu5K1l+G5yDdAgnFQDu+MxO88zQNvs6lad/Mc4lTS0=;
        b=G6KEDkwYG/uahN+Anp0PfIotxOObTCxaPcmnfAbo5C0U2M6HZ028K4IQhm5lc8X5rC
         ON5IyAkPU+Yo8HacY6wj4yICCa/F28jwBIQmWbUVYjEcGNLekcQ/iRp+twRB1ZTdq77y
         MfmDDAicKH5FGL0vx9OxFz5YELHM51HYfp0toUzRksjR/EhPYhCC0+2DbJKm3OiIGqCl
         7RTK6Amp4QY6i7zF5Dvw3mtBlr9BoQsTeAnXkt17+y+NTi9Z61uYXJ92PK9k1hLX+Bc3
         LJl7pLln5WoGlWUuBOWifHQrwd+MdVF56uALPANNkhvNppaKtblkrF7BWEPeBRp94lsG
         8H/w==
X-Forwarded-Encrypted: i=1; AJvYcCVyEsMwObilb46xPlDF5bY4Go4UHLXpmuam1nTWuT70ciqVonzTV01hW3PPJK/g4LJVsm4WTxobboaLYYUS06ZgHptuoU8q8OYD2+W/
X-Gm-Message-State: AOJu0YymonVTpHp0xjuYLeJR6eUpRaaoFHSE5LYpa/r3qNEKBtwikSCk
	8WTqZWcQDzJrOMS3bgYTiZPJztU2a5W3Il7cqyl92R+YT6g4aSm0YTKEIzljeA0=
X-Google-Smtp-Source: AGHT+IGuZwQXIly3rfutzxzjwTkwPGi8xr+VoRd4Gi1yFWK4HNzVU9OXfNjqAtn27yPYOkpgG8rD8A==
X-Received: by 2002:a05:6a00:21d2:b0:706:5d85:61a5 with SMTP id d2e1a72fcca58-70eae8e4676mr2894239b3a.8.1721928299106;
        Thu, 25 Jul 2024 10:24:59 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8837edsm1418937b3a.148.2024.07.25.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:24:58 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:24:56 -0700
From: Joe Damato <jdamato@fastly.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v6 0/3] vdpa: support set mac address from vdpa tool
Message-ID: <ZqKKaLdn3DBr7WrK@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
References: <20240725013217.1124704-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725013217.1124704-1-lulu@redhat.com>

On Thu, Jul 25, 2024 at 09:31:01AM +0800, Cindy Lu wrote:
> Add support for setting the MAC address using the VDPA tool.
> This feature will allow setting the MAC address using the VDPA tool.
> For example, in vdpa_sim_net, the implementation sets the MAC address
> to the config space. However, for other drivers, they can implement their
> own function, not limited to the config space.

[...]

Nit: the subject line has misspelled PATCH as PATH

I believe net-next is still closed so this code needs to be resent
when net-next is open again in a few days.

