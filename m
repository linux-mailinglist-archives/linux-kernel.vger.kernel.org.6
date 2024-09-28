Return-Path: <linux-kernel+bounces-342323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4FF988D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385AD2829AF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39865381A;
	Sat, 28 Sep 2024 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXFUW/fx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBB171A7
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727490645; cv=none; b=uMhZuxlWisd05zOqbKRzS6pgl75dHUdvb7ENHe/c5zTxny6hDbcf4HKV8JAivSI5I3zlpNgkJmVilhHbPI3CkirVFtideHisT+L1tTvo1uE511k9uUwl/dflqSCbOP5lbQ8WX0R9BdSOqEHrwBPCll/9XcS7W1HjNwjDUgL/T74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727490645; c=relaxed/simple;
	bh=WyH/4vdnVcLBkVnBup1I/7f8Grtzl0gJ1xiYbKUceXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phBF220PNCVKSoytOP6urK4d+2f7gkt9NW6bqW5jo8d4vP9nXWTuf9hL5JzaKscaqZd6CbxcH8d1SrN7/vXDHlsl8EdjZubXaBSERVigVXCFZv/+ppNY9yCn252Qjorz2FZYB/QjPAkFiI9X33DIVIuJmC1dhtE+oULBP4LQD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXFUW/fx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a93a1cda54dso357519766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727490642; x=1728095442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZ/wHMNg0d+dVALsuK0UnbKStRq6V9Y0t0+9ftzzOzI=;
        b=cXFUW/fxwb2E3cHEgibJdXIwvSmFhTWsUCbunVZgQf+RL+Wl3WzSwyonA03HZiPVoq
         EMFi95l+JCLx4LfARsyFn5+DeTehOLqBzuF35eIJhrsukW0kjpRanEjHxck5hQrEfMU+
         tqaRF6NfT3Zcky3q1/Hw6ZtfwiLB+PE+6c+sz7lfDmCyo173E4pfAWFcoKSnx5pN04Bo
         vFu9JVCr2pGwmEkh5Z1WjmElpO8/IpkjLV+9R16dLtTm/nTl6gr/gvTppxECbwog6qgf
         k5qoeXBDUeTY5Vz73mmKss1pPeMVfimsw5YD1UnfxZP7vCG6dypLHW/lNLWT7YJC2Uya
         CIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727490642; x=1728095442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZ/wHMNg0d+dVALsuK0UnbKStRq6V9Y0t0+9ftzzOzI=;
        b=WvSmKsKJfiSODy2ApaVGy0SmjYwCxWi4+5Ynaqt6ThVHzn9kUC56D/glIiJUPLuyod
         0IKsRDsxJPfukDoYRQ1sTmmlqAHwf6TmPvvOcP+Fenq2vOuSHciPBvcYKJIsTrRuGK5g
         Diz/jheKOpwJqBbHvhu3y0nhpcMycA16irsjc2ize4wasu1qcWvFXpiiljuFvehxGKUd
         QE6VWEmbbTeaIjgxO/8zct9CY2p1phrcIveyw67W1lV9pzbGw9qJsjh6FNBuTcTv2Kts
         QR9ithPKbeNDtDSPtM68BJ80V8rn3dkSMEp8eEUoliOz5k8SxNgSKq4+pGGU10zd+Vw5
         WcKg==
X-Gm-Message-State: AOJu0YxEFBnnw7Ha2qZtKNcIeEOmKDnmfbY5kAm4L/7Ivx1pL8blNwsQ
	a77MR6nlnlLC7sjTP2UtXZvp+H4nqJ8Q8SDvUoXVc99tFLYCoGg4u0h+UscQ8CVv+9aqwonf7fC
	YnJ2IYbnYa95uwFBZjyHLWt5qjREmIHCYf6IM
X-Google-Smtp-Source: AGHT+IEckE1V7emNRJoahGMNy6LaBiiwJXt/HE2bsdWFZ8PKiaKO8kTBJzYFXUhiDlBPaxpQF3bRj2SzBSKg6Z8lSBY=
X-Received: by 2002:a17:906:794d:b0:a8e:a578:29df with SMTP id
 a640c23a62f3a-a93c48f0c1cmr534977766b.6.1727490641730; Fri, 27 Sep 2024
 19:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com> <20240928021620.8369-2-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240928021620.8369-2-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 27 Sep 2024 19:30:06 -0700
Message-ID: <CAJD7tkYnCSe-pXx86PypDVivkfueiipv1cizDGBNs-sVmZqRew@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> This resolves an issue with obj_cgroup_get() not being defined if
> CONFIG_MEMCG is not defined.
>
> Before this patch, we would see build errors if obj_cgroup_get() is
> called from code that is agnostic of CONFIG_MEMCG.
>
> The zswap_store() changes for large folios in subsequent commits will
> require the use of obj_cgroup_get() in zswap code that falls into this
> category.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>'

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/linux/memcontrol.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 34d2da05f2f1..15c2716f9aa3 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1282,6 +1282,10 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgro=
up_subsys_state *css)
>         return NULL;
>  }
>
> +static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> +{
> +}
> +
>  static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>  {
>  }
> --
> 2.27.0
>

