Return-Path: <linux-kernel+bounces-276704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FB9949744
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B5C2840D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED606F2EB;
	Tue,  6 Aug 2024 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcXFh1kY"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5A41C85
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967256; cv=none; b=bXSGKjI20RBCBYwRmXAY8KREKW1uDwbvVG/wBkT1Riu7qqayJOl8xyWEQpziOdrqpDwhVUrsRpRMVss3dRBJvt3Vj4aki+Qb03JZ1Dg1F/NUowMYAjwI2biamV4T7gmeyEc5kdq5VtR06TTEjc1xF9alD/2E1sa7iTivbQpk6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967256; c=relaxed/simple;
	bh=caybVKr8EPWx0odtlLt1uBSypBqrm29kv6r7neyat+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE1lAgreN/rren2UBBhm951UstYeI2/w69HWVmZcEudnyEW5J1uUj41RSFlSDg2avdeKsKnXUXOo3X38mglOdaB37mUhQ3Bwhz9A9/CCQyqxSsWGHDc7yG68MZLbjNdkdzXKxBL8G1/P5YGhtmzIemYrKrWh+X2vbaCzGHpKeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcXFh1kY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so620252b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722967255; x=1723572055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BG2lYAKh85KCdrI25BajB3M4AUpp0fE5LFzOfkLW8j0=;
        b=bcXFh1kYZhyOsEi0O6iT98XMRlXxup1mielkHKioHU+gT0lfc4iN4UPDhZkeKFw38u
         XDxdwSPXWmdo6nlXFmzMA/QRXS/DXZCos2mz0hd0S+TS4hLoTS60yAKqP1mcpmUhpjsm
         9fSqs21PWPln+NWJiCfZ1GEWXvoUbu6l2KdJQi4mn8hj43q6LvioPvLSbXbsSlFa6r0i
         YVPgod0zQpbnWvoJIL8Oeg9BesknINUjfTFih8pEH8WvGv64AV1pb31iyM1/xRvG+whN
         sjE3rJddSQmynZjkx/ub29zf7MrzAB3ikygoyk35jiRuilQ2r6PTh1VLbanJAx3Ky13k
         GCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967255; x=1723572055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG2lYAKh85KCdrI25BajB3M4AUpp0fE5LFzOfkLW8j0=;
        b=r0jOcZjcAxYIQkkk1RUAhah3cPH7H2HSzOBGjEyiNvNzcRRarx/YmBXG22m8k1EOe+
         71+4oyz71xNHcO4YWb4Ra/5eX36mbT9/bIeoVjK+IxjbqUSQzlSihw9XNjufbn/Fcikc
         6xXs3jSU1z7bapSo9yYOfbdNB4V1SK/xkvXDmP0eXR0ms99L1UsXBEJeNxPlNUPt1f7U
         FK4IKcQv5+bIukZb5WBJMGmHKxX3RonQKE2e4dplx+xoU90ug4uN9eLnCGQrbmc0cuyy
         UmNqjh+VLI30rLa02t1tQBBo/XwK0vZku3BW1o8S9yXHLuHstfmL6q0QRVMEJNWGfApc
         mpSw==
X-Gm-Message-State: AOJu0Yz6gcg7J4wkQHZqtDo81KoUuGCRj73OxTPriEmUh+D5D43I/ydn
	FGCTC9aiEhJvM0S08Lo+kieHllVLqgvUIyr/WXM9Uis8DwotyISK
X-Google-Smtp-Source: AGHT+IGa4ey5YBbJxQ11TeMRhyyzZgNKNcY9Vh8cfMO9qt0PlAVpWq5NwfhORAgtw8f+Nm62nvH1xw==
X-Received: by 2002:a05:6a21:4603:b0:1c3:ff33:2471 with SMTP id adf61e73a8af0-1c699579845mr22413161637.8.1722967254548;
        Tue, 06 Aug 2024 11:00:54 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b830f296d4sm5109153a12.68.2024.08.06.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 11:00:53 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:00:51 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Leonardo Bras <leobras@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched/topology: optimize topology_span_sane()
Message-ID: <ZrJk00cmVaUIAr4G@yury-ThinkPad>
References: <20240802175750.1152788-1-yury.norov@gmail.com>
 <20240802175750.1152788-3-yury.norov@gmail.com>
 <xhsmhy159mz0g.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhy159mz0g.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Tue, Aug 06, 2024 at 05:50:23PM +0200, Valentin Schneider wrote:
> On 02/08/24 10:57, Yury Norov wrote:
> > The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> > even when cpu != i.
> 
> For which architecture have you observed this? AFAIA all implementations of
> tl->sched_domain_mask_f are built on a per-CPU cpumask.

x86_64, qemu emulating 16 CPUs in 4 nodes, Linux 6.10, approximately
defconfig.

