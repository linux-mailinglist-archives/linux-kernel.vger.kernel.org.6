Return-Path: <linux-kernel+bounces-351622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399429913E1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 04:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BF5283A79
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4C179A7;
	Sat,  5 Oct 2024 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ElCF7DLU"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D0F510
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 02:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728093923; cv=none; b=Gdhozi40pp5BnrYAJLyBoEXlE0eB9zgoAftXPgOj9gKJ9auZA8mW0Y0EBhLd5/gGgE9JehqoPDiF79F4Ea7WS/mVz4b8YU5GERhG5wMb9yuhPF1QjNg/jtGprfW5tYDGmrLZhxl2LqfxHPFWoccaNP+gKYLUCHDZQyuW36qODZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728093923; c=relaxed/simple;
	bh=Wqk4NdyE4mBNZXbc0xHnnm1/cf2WxGb3V6wmnl04GmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBhPMWJRihi8s0VHeDme2QJGTFk5KqNl5Ls3vNmqFY2Xob0nTVoD/smXiQB5CDDG7BE1V/ydCREW7+gbrJkW7EY0unBad+7eK7cSs/RpDBZV7A21SzdgVml5r/NivS8dvXJa5Zkd9izcpTLEbAyKhE5ve3JTrsdG8pZFWMIHtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ElCF7DLU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-458362e898aso17533511cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 19:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728093920; x=1728698720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEhLPagKqmxdlGFOzumHeX1yLsUek+sBAi9FRIB9rt4=;
        b=ElCF7DLUnSNcg0HBaoCqcKZxVqYVXcLknmsLDR3GIx79nbRCzMqrqA6c+yIT45l9SL
         Lxtt3P3ckNC5zLzhvOCeu4hNtzPee471QS7mWwBHyPlXHgay5RfGkkYg6y92F1HIJUlU
         ca6/6F0qgYoEV+eWmY3pHYzgCrpyxa5BVnd+wR2vR/Do27KzsemS8L5rzWAbNTC/Bk0i
         eEY8bQFnYgubybOQZDLqOuMKzPzjSU69y3rfCCvB9q5rNpfAiVNEWhV4REhp3Bhj4pzg
         3j5FKjEnhNwCceFXFHVlQW7XqL9WrIV1H2k+NttLqcPXSi1qBhY8Bvv1fSlIgGRJOhcd
         xeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728093920; x=1728698720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEhLPagKqmxdlGFOzumHeX1yLsUek+sBAi9FRIB9rt4=;
        b=QaxJpqK9zzkGMfKw5DTQ6rZGnDObMce8XCUrVcaoecv2sKklTsnw/YSWV4xDWlKAvH
         VFhEjqb0GWUJ2NTSIln3SsF9CmNnJ7HELZDM9Mrn12H6yiMK2HGG58YOmLCVBRnPPWyb
         SNrHBX1+P/rihgA0ywK/7NXLU2oNlQv9i4lE0YO0hOfUqfhpr8sY7/pDFK7XOmNkvAZk
         pf9dCOAaO0Pp/KlY2wFL1Z5gBY/aVXLYJ8hUihVrru3AGrf00yn9NCWxLuvrUxGeImJ4
         i8dsm81hMZvoxC+HjuHFg1XADZIE2H/J/6bfsz92LBOjKdRkPW295epFzmuPssbxGqAc
         dbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDNyGVckNJi9bCVo4wsM7JwVVMoKNTEE4t1ElZykjEad2SmvwCNzM+c3x4OTQgKG1oikA6cGlOyP41CTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmq0BG8Z/qwyIlN9WngU+jkAyYFTmEoa1hwei+vA3XPR+CDSl
	1TVEZWbJHIW2wlSwdl7yW1pHPjhU9khQcF1l78LVzLu13qC1s26UGiv+E6Xrd1g=
X-Google-Smtp-Source: AGHT+IEaAhLnt5108KqcxhCMvI7wwCXcVQpEadI5ae7VyUaP4eMqAHE03pnRoDn895ttkV8buISxDA==
X-Received: by 2002:a05:622a:148b:b0:458:4e4c:b692 with SMTP id d75a77b69052e-45d9ba7a0eamr66087751cf.36.1728093920310;
        Fri, 04 Oct 2024 19:05:20 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74b2123sm4363551cf.20.2024.10.04.19.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 19:05:19 -0700 (PDT)
Date: Fri, 4 Oct 2024 22:05:15 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, rrichter@amd.com, terry.bowman@amd.com,
	dave@stgolabs.net
Subject: Re: [PATCH v2] cxl/core/port: defer endpoint probes when ACPI likely
 hasn't finished
Message-ID: <ZwCe23k_IDefi15j@PC2K9PVX.TheFacebook.com>
References: <20241004212504.1246-1-gourry@gourry.net>
 <6700836317627_964f2294f2@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6700836317627_964f2294f2@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Oct 04, 2024 at 05:08:03PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > In cxl_acpi_probe, we add dports and uports to host bridges iteratively:
> > - bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_dport);
> > - bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_uport);
> > 
> > Simultaneously, as ports are probed, memdev endpoints can also be
> > probed. This creates a race condition, where an endpoint can perceive
> > its path to the root being broken in devm_cxl_enumerate_ports.
> > 
> > The memdev/endpoint probe will see a heirarchy that may look like:
> >     mem1
> >       parent => 0000:c1:00.0
> >         parent => 0000:c0:01.1
> > 	  parent->parent => NULL
> > 
> > This results in find_cxl_port() returning NULL (since the port hasn't
> > been associated with the host bridge yet), and add_port_attach_ep
> > fails because the grandparent's grandparent is NULL.
> > 
> > When the latter condition is detected, the comments suggest:
> >     /*
> >      * The iteration reached the topology root without finding the
> >      * CXL-root 'cxl_port' on a previous iteration, fail for now to
> >      * be re-probed after platform driver attaches.
> >      */
> > 
> > This case results in an -ENXIO; however, a re-probe never occurs. Change
> > this return condition to -EPROBE_DEFER to explicitly cause a reprobe.
> 
> Ok, thanks for the additional debug. Like we chatted on the CXL Discord
> I think this is potentially pointing to a bug in bus_rescan_devices()
> where it checks dev->driver without holding the lock.
> 
> Can you give this fix a try to see if it also resolves the issue?
> Effectively, cxl_bus_rescan() is always needed in case the cxl_acpi
> driver loads waaaay after deferred probing has given up, and if this
> works then EPROBE_DEFER can remain limited to cases where it is
> absolutely known that no other device_attach() kick is coming to save
> the day.
> 

Funny enough, not only did it not work, but now i get neither endpoint lol

$ ls /sys/bus/cxl/devices/
decoder0.0  decoder1.0  decoder2.0  decoder3.1  mem0  port1  port3  root0
decoder0.1  decoder1.1  decoder3.0  decoder4.0  mem1  port2  port4

w/ reprobe patch

# ls /sys/bus/cxl/devices
decoder0.0  decoder1.0  decoder2.0  decoder3.1  decoder5.0  decoder6.0  endpoint5  mem0  port1  port3  root0
decoder0.1  decoder1.1  decoder3.0  decoder4.0  decoder5.1  decoder6.1  endpoint6  mem1  port2  port4

> -- 8< --
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..6c0cd94888a3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2088,11 +2088,18 @@ static void cxl_bus_remove(struct device *dev)
>  
>  static struct workqueue_struct *cxl_bus_wq;
>  
> -static void cxl_bus_rescan_queue(struct work_struct *w)
> +static int attach_device(struct device *dev, void *data)
>  {
> -	int rc = bus_rescan_devices(&cxl_bus_type);
> +	int rc = device_attach(dev);
> +
> +	dev_vdbg(dev, "rescan: %s\n", rc ? "attach" : "detached");
>  
> -	pr_debug("CXL bus rescan result: %d\n", rc);
> +	return 0;
> +}
> +
> +static void cxl_bus_rescan_queue(struct work_struct *w)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, attach_device);
>  }
>  
>  void cxl_bus_rescan(void)

