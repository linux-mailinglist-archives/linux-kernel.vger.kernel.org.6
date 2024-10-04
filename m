Return-Path: <linux-kernel+bounces-349964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956698FDFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EBD28247A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A013A3FF;
	Fri,  4 Oct 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KfUKIzjX"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C181AB4
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027750; cv=none; b=rFBpOt9WsN33ifzCfHJk74tFGqt7pGG2kHSSKraMbLb5WU0pqxhBl1j41LicRP2LR+XM52QbCK+d0tqzh40w5yLQrd0eivolLwz/cxYCn+6S82tW/xAZ28I21FJApm8uULLXD4dLkd5d0tmbPYsGeM7ToSpX87R6sVdK+O8S0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027750; c=relaxed/simple;
	bh=9pi+hAuP8EGPNwpKr1Im7g+5MlHNqe+RLYVFydZk5Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeWkCzD+i9EVoxqtuMlGFL8B0ECnf5UD4u8mVYR/7+gn72Sf6zbYVapAz8EuOZxEj7S98nG60ucLn4x48YCwwLzHVwNacqOpVWDL6EGqMjD/BgOoS1JjUApfx22vGBB0pcNVeD1IuC1NIbnrenAQl2VCHqUomJA6dl8jOQirFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KfUKIzjX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2facf48166bso24004781fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728027746; x=1728632546; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfkpvxGZDlHyxBfOk50z1ys+xcSsTluPwE//fvabJSI=;
        b=KfUKIzjXv119UDDJ8oUpihQNRDoinSWrbszJWUotDcltzBeNPHy8u4houPNkgWVNCt
         /hJBUAGlsH3spqMFgiVlBRSnndbh2HUWdySExpWjMAiN3YlMop1eQXcfZGSPmn9FYM7H
         9k8HAHiHGjS9qCMvbeyFTxtlZkkJ1ALZ5E0eamOYaPman2hmHaHIEaUbcZe3kydPppP1
         I1YbmSnLeaeNdtMkQmpBfOC9PH1UMIXmAYApcegxz9PixsWWigp26jsvqjH8aprrjBlF
         ptECCN00w6Yo6ncPh9Yc1oIWRxkqe9pR9EPfjFOgmqSZYfdDaLeVeGvU0WhPxdW6quo2
         qZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728027746; x=1728632546;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfkpvxGZDlHyxBfOk50z1ys+xcSsTluPwE//fvabJSI=;
        b=wKImw/IdiJa2VcLZt0YM9qtN3FlxGfh8iQTAPeMXRIT6QLSsUfnCJC7JLc2aknVD+l
         S0t5EmvnRDcsc/qAboXHfh4oKQqdUXUP5g2kiMEGqUm7U3SrjWXQymXY04JwyrI9l1cD
         VRDa2aYPkoEKUg8TkytzOEZz+EJX2WlYmcZZAbyp1X6hK0rmuBlKn9z9+rypMIkND/jG
         o+BgRE0/nAociUtrEjzVT8NVu3LHowcLalrzk7G9Wh/7jU9J8RrwdNmYbNG9oMJ2iIJ2
         vgpbnZdN2LmJYvVN6C8qPk0vLypIsgYkCwu0MHmGnK3laIgBir8OAjKaIVF6D6MdarQs
         Zosw==
X-Forwarded-Encrypted: i=1; AJvYcCVm7h/PMXwPnjvjDqbLcpnqcjP6UH2y+VkI+rcMP0xIah08Yd5GRJW6Y8NShylTHHzmu5qb79tVMrcNGyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzomhIZVD4T8ar2eIX/wGZJyf+jJMleN2XzHJmh6dl/Tlb7zM5J
	poCRwEQpcSuXttQUlUo9kvybTeMy4xqkJFzMiIflv8dDELkuCOsffBG/IjkdlBc=
X-Google-Smtp-Source: AGHT+IEV3wS/WHVH4MjVM0LREWLDgAJCwHMNSYLFPDNCEtzxI9lCsV/TKRrs2+z9JTjJO2HCvnGhSw==
X-Received: by 2002:a2e:460a:0:b0:2f3:f068:b107 with SMTP id 38308e7fff4ca-2faf3d79065mr7208681fa.40.1728027746069;
        Fri, 04 Oct 2024 00:42:26 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb05650sm1865976a12.16.2024.10.04.00.42.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 00:42:25 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:42:21 +0800
From: joeyli <jlee@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Justin Sanders <justin@coraid.com>,
	Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20241004074221.GK3296@linux-l9pv.suse>
References: <20241002035458.24401-1-jlee@suse.com>
 <172787504822.64996.12000204584360248821.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172787504822.64996.12000204584360248821.b4-ty@kernel.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Jens,

On Wed, Oct 02, 2024 at 07:17:28AM -0600, Jens Axboe wrote:
> 
> On Wed, 02 Oct 2024 11:54:58 +0800, Chun-Yi Lee wrote:
> > For fixing CVE-2023-6270, f98364e92662 ("aoe: fix the potential
> > use-after-free problem in aoecmd_cfg_pkts") makes tx() calling dev_put()
> > instead of doing in aoecmd_cfg_pkts(). It avoids that the tx() runs
> > into use-after-free.
> > 
> > Then Nicolai Stange found more places in aoe have potential use-after-free
> > problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> > and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> > packet to tx queue. So they should also use dev_hold() to increase the
> > refcnt of skb->dev.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] aoe: fix the potential use-after-free problem in more places
>       commit: 6d6e54fc71ad1ab0a87047fd9c211e75d86084a3
>

Thanks for your review!

Joey Lee 

