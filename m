Return-Path: <linux-kernel+bounces-301196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C095ED8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4147284178
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502F145B35;
	Mon, 26 Aug 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1pnK8b73"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FC29A2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665284; cv=none; b=qotzgxR3uxloBKoWKiJTDrBuOmLY6gmd2W4lw1ZHahao6+wemXhxXt8PxTl4+H5Q3bIEqh0KwlbV2Yg11NcZOuvxBG/dBDjKZHsjdaz7VEbx+PgVxwYHSXYX+0bvMT6UA3U+gwQk+7tgvsvHhk4BKoYW1oj39G/0z+1HDqDUUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665284; c=relaxed/simple;
	bh=rvrYcCRa5AIUnGlGVp8fSlAueERu7SoUZsYnP/E5kx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPUQzenKAUaCELyiA3Poqg0uLwRrqzjsB1XobCb8hjSVwKBJX2yNSld7Q63NzgMs87644x2TWMOjZN9pnTynEsGCIXCS8TislMnOhxYqP4ccyoT3GqZadh0rF/vraiNBhyp6MidBNX/KYkPDf31sMQSTL4Tnss14dYAsJWYAChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1pnK8b73; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37189d8e637so2425863f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724665281; x=1725270081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/yl4cDXA4JumAEECmUq9Berw73DpEmSmXfJ3tVlu2w=;
        b=1pnK8b73k3VUyyqU9gDca6XdhZTWXqrX0EStHAQ+9IiLe9rrQjn5dKDY5woDc8F90J
         S/nxA/n5cuKbetXQV4CAD8HOwoEEdpE6V3Z0ZdHw7u/9QEVs10JAnXJJRZrsacLEBO50
         byxJEwGKwxPxaTBAjCTapNb7IQASo4+pS4rwU10C9tFyTY+LnW/fgYAmBiJfrbX+UapM
         cIJOyOpdBne9/AhnMrK4JnnCqvxQhw360yrI9x6GNycLjZZkFnVixj0vhxVaiZcyHGhL
         2Oqq4WVSl5+O9JHu7wgPr+p4WL+bUXkFMNDRr+xM0cxdJXGSxWoasoPwIPAt7X36zsJR
         hbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724665281; x=1725270081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/yl4cDXA4JumAEECmUq9Berw73DpEmSmXfJ3tVlu2w=;
        b=LuKrkyolCB9O49QUCMXT9qlcwnt1rg/nczWzXHqZZvNdVtC1iACj0pNvq0/KItLqkv
         A3eIHxhjgkzTaFCZFl7slGUyzoLqAZ2BEiw70Pc12O2Uip3G2HyQcxUChbTh6/edxtn5
         qzBUs6BWy1WDl1xfucFDNSsOvWA2yCKvKuE5ZdObOIY47wB5qZtAy9zB/qzzH1zlhLq0
         cw5Zrr4eX1MWhJhVdc549T+NfXWbZmQRDGuvvbZVZBAMdSfXDk7BZFCIiMijWwcrVnFW
         K998vZu4814UJq3m9P6MRVeeXKWtIhRqTwd8+74H0sWKK5ZgYH9GiV1lta9E2fV63bCL
         hH3w==
X-Forwarded-Encrypted: i=1; AJvYcCX4YSOHxRNlxzUzn/0j7R61DB68QHHVDQTgzdIaDxOrvJpLXaRTPoIjDmgvquvIEHcA6HmpB8K5ZpSyj0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXw/YolPIJ3EQtFHZO5MOngfVNbKfWHs7xbRyEMafKxbx+RtUE
	tRaE81MmmGVM40W4IT4+5Gy1UrOCo6xWyzq+IW0XRBk0bcwIbpSjo9xYdnqNfqw=
X-Google-Smtp-Source: AGHT+IH2yCKZy4Z6frapl1ipVektXUVQIweouWgx90ThJuXoGKGjBkZtW9Gs6rZt18EuPg0v+LSAlQ==
X-Received: by 2002:adf:f451:0:b0:371:8748:cb19 with SMTP id ffacd0b85a97d-373118ee926mr5948602f8f.56.1724665281212;
        Mon, 26 Aug 2024 02:41:21 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373082697f8sm10264617f8f.110.2024.08.26.02.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 02:41:20 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:41:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix NULL pointer access, if PF doesn't support
 SRIOV_LAG
Message-ID: <ZsxNv6jN5hld7jYl@nanopsycho.orion>
References: <20240826085830.28136-1-tbogendoerfer@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826085830.28136-1-tbogendoerfer@suse.de>

Mon, Aug 26, 2024 at 10:58:30AM CEST, tbogendoerfer@suse.de wrote:
>For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
>allocated. So before accessing pf->lag a NULL pointer check is needed.
>
>Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

You need to add a "fixes" tag blaming the commit that introduced the
bug.


>---
> drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
>index 1ccb572ce285..916a16a379a8 100644
>--- a/drivers/net/ethernet/intel/ice/ice_lag.c
>+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
>@@ -704,7 +704,7 @@ void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
> 	lag = pf->lag;
> 
> 	mutex_lock(&pf->lag_mutex);
>-	if (!lag->bonded)
>+	if (!lag || !lag->bonded)
> 		goto new_vf_unlock;
> 
> 	pri_port = pf->hw.port_info->lport;
>-- 
>2.35.3
>
>

