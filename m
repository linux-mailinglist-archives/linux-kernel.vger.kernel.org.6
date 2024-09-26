Return-Path: <linux-kernel+bounces-340471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5113F9873D3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A31280C33
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A11C6B2;
	Thu, 26 Sep 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y2rUqbGJ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BEA93D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354986; cv=none; b=Q5Nir9ZElVgsua+EUOVoqltL6nQcLGW4klhrZxY46nC4S0/qdHYRdwcJSsA89m104JJP7XUUNmXprVjU4y4/Covj0S3lcb0GBrrVz1u/XbF+ZWqKjZGPXIYr4POSrBWQJ5LnjRNRnxanVzMpChZG5ghGl3QBeo9bolcDjKE9L/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354986; c=relaxed/simple;
	bh=PcAQFQWF3yzOYCy67M0riQ3CDorxWvR8/K5Mqap2swo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtslcOofP3rSOzs9oVRx6IS3vO7TleLMU5LuGs69tZfs3KtaDbXjixGqveEspA8MXzkIEIr7fUElAvZw3qv9D4QZIx5eP5v0Yq73NHKSHRzIVjGXayUPwPj8gUpCmmg18Wo+KFAF1bL5bTBo4WaS0BNPEbwCx304WBxoel2fJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y2rUqbGJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d43657255so141078766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727354983; x=1727959783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjJsOvgildp9H/xsUULy2gDxt7xA3HkFuJwBFtYzD/o=;
        b=Y2rUqbGJ9qUCknmaN6j9ClDZN+q4Edfm819Rzm5JVvata0NDa8rBR4hHV6mry6+ND2
         93JLjme4Y65aL84cV7kvoBQIhp+eD0RqpH9k7rMFOa3xWXqFXmOIJ+llDjAMs/aC2+YS
         7Z6FU7Z8e2PU2VMUUeVeE/0psEQkRj4s2M19Lg4MP5ELwWbVBCellgUUX0h4tQxwXAQu
         g2V5u/Yf9sBY665WuJ8L6EuDEkoW5DxWL7rhPH0TPT/0pEvfofTVORvDpmxXVdJVcX13
         NeITXlHwkKLNtWQZm/jTK59RC3QDz/Kw+ghklxj3TiydkYcSdrm6PN1QGg/hNlIyVRvg
         Ymvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354983; x=1727959783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjJsOvgildp9H/xsUULy2gDxt7xA3HkFuJwBFtYzD/o=;
        b=R/xJv3hl8lxll8e7LuVQmtGS/KiAyVnJR30qfaAYov+2veCeCQ+Ho7n7aZTsjdkW6e
         KCt7zythmk4hPekw7g9FriOsBBgELFLOcWy8BfEPKg8FnvXiDXOY+7QGa/Nz8MnPxHtx
         Z8Jdm7DfV7s8ag/9w0W66YtH9t4WtgmZxc9r9eYkdNuaOV9dWq2Fhqv+lFFFQnnSilkb
         jstJjN628Br2m+0ikgQNw86Nx2eF92o9P0eYH/YJ5JycUKp8UsoqMd2l3UhFR94dostX
         6DaHCNtnmVvOX30UyyXxpigPUip8GZJV/FLf1dqKX7q+K/NcOXrIUX4qrGVjahTfRkxI
         VjPw==
X-Forwarded-Encrypted: i=1; AJvYcCUQARiOtmzqV9JW12E198a8KsmQ7coxgE3KH4OiMSnhiV62mD++IXfcwfI8IdePEiJgdnJhnycWbwDQz7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjYJZAWXyIv5ygh3XJr/4ihSSwjr5jHNsXmNqbXtGEFP3X2yRy
	09GVkW1agn+sUketzKlIdrsqx2Xk4sTr8S+rur2SYfr5+/RMT05ihElnr55tABA=
X-Google-Smtp-Source: AGHT+IG5oXINx2+BHWwqkm9/6dgecwNYSEzGznLHq9dYTb8oZDl/WOd28v49JduwM7ansKFgf/vIqw==
X-Received: by 2002:a17:907:31c8:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a93a063338bmr572804466b.43.1727354982994;
        Thu, 26 Sep 2024 05:49:42 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93a1a8c71csm232348666b.87.2024.09.26.05.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:49:42 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:49:41 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, chenridong@huawei.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] workqueue: doc: Add a note saturating the
 system_wq is not permitted
Message-ID: <ipabgusdd5zhnp5724ycc5t4vbraeblhh3ascyzmbkrxvwpqec@pdy3wk5hokru>
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
 <20240923114352.4001560-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3iq4bhwwm5dfsvhf"
Content-Disposition: inline
In-Reply-To: <20240923114352.4001560-3-chenridong@huaweicloud.com>


--3iq4bhwwm5dfsvhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2024 at 11:43:51AM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
> +  Note: If something is expected to generate a large number of concurrent
> +  works, it should utilize its own dedicated workqueue rather than
> +  system wq. Because this may saturate system_wq and potentially lead
> +  to deadlock.

How does "large number of concurrent" translate practically?

The example with released cgroup_bpf from
  cgroup_destroy_locked
    cgroup_bpf_offline
which is serialized under cgroup_mutex as argued previously. So this
generates a single entry at a time and it wouldn't hint towards the
creation of cgroup_bpf_destroy_wq.

I reckon the argument could be something like the processing rate vs
production rate of entry items should be such that number of active
items is bound. But I'm not sure it's practical since users may not know
the comparison result and they would end up always creating a dedicated
workqueue.


Michal

--3iq4bhwwm5dfsvhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvVYYwAKCRAt3Wney77B
ST+MAP0fDxXvbUEc5ey/TpWnTsLmyHSf/YiXugOiki+455jukQEAmF+vWJTMxP4R
1GYHr3HW1PTyXSE4IM+96+DNdw9C3w0=
=qxwb
-----END PGP SIGNATURE-----

--3iq4bhwwm5dfsvhf--

