Return-Path: <linux-kernel+bounces-365129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E4099DDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978C31F227EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5A18784C;
	Tue, 15 Oct 2024 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PahomjQu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059F18732C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972391; cv=none; b=XS9x8LR6RI5R4Ez7VCb7gY5g0CPv7HwnT37cqP/VBSKgakZvyg2XqkuiuEsf6ebexQZA3oSMYk6tsojEyxBOLDDwmsMhQwQVMYrpoHEkGuIiUC2VKcd/hoA17AmdQm49BpRleDNL2T/Z5vF6lhVj906yVGIVswiOy37gJgWmF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972391; c=relaxed/simple;
	bh=wQKOSCNaLV/LcMBMVuZv0A2kky3q7m8FVa6KFXCvPbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCdbQgO0Z+N06GiXT8CzXSYkT0CkQTPVXJWbiy4oWn6uzdNwbSXi7YeXgpTc6QCIx6JP7n/gEASBsxRbIc6sjlx9casgwO5J2kV8+A5XoBFG2gte0vRGSNSTFIEjx0fJ+KfFL9/+Pua3mvYBSTJc9NRTfzbi37U3qe4d3i3U7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PahomjQu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728972388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tgZ0+UyvmPHPLy5zGIiiGdwLyCG+2QuBi7CujPJYYQ=;
	b=PahomjQuis38Y+f5gIbMKrm2AOhQ2oXgatAixjiQUFjfDShyhBZXt1J7YMqCzuM7aybR4U
	0pv8vDnhrJPRnRIB2klTldwc/xZ8Pft9xqeoOyJCt0zWy6ZB4owPHb3+uyF9/bvDANiG51
	vVsoHxU1l6RrmGVLsYIIClJRniDEe4s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-iBcRaS2JORmKmo9sp2z30A-1; Tue, 15 Oct 2024 02:06:26 -0400
X-MC-Unique: iBcRaS2JORmKmo9sp2z30A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a23eada74so37154166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728972385; x=1729577185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tgZ0+UyvmPHPLy5zGIiiGdwLyCG+2QuBi7CujPJYYQ=;
        b=Zo8kMxJgZfk5vGtC2cOQAzE79yExZNPdQ6wYGEO85L3cFGSEdXtYdE5eHJUHpwIMSQ
         En0giCpw0s6vnUpdH8KZ/Xyd3+zjgdLdNS2um4VL/TPz8pciuPui7BJfxEg+iu2x8lu6
         jG2XrKf+CD+31UjI8ZlV13Vp/VyUj0p/lgEZeBpKT8H3jEcRuj3CI1JNbCi7u3EH2t/A
         PLNbPI/fmDMxTwNYZc3NLai4MtzPjN8sNgznxg3SMwW90roYSC53jpTm9OogqopRCVfO
         7/wFJAvL+e4JbQGUuNn5/ysYgQ5A5iXK/zHZ+CxloKdK3SUon08v59uCXLgCnkRLLNq9
         24RA==
X-Forwarded-Encrypted: i=1; AJvYcCUt02P6gqi/+tHA5xQxzczSysV54WIJEtgZj+nyHufm0gOLs89Ous3obVJ6vyDhwoXtv+fNml3nLSOrMWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDC9rt2ahtZ0HY7GzaHhdPFyH71zQJ7nMzdABpscIKNb2vMEiw
	/pCi0xkFHTOWqLrJeOQ/iSdrTLGb7kB/XGwwLbJsHSAb2adhzxTG+vPhE3eC9JAhTvqhh9k7SvK
	lNcdWiU0JxLdyhPFoQn/eC3gMz1e9Y/wyOOLCigjnwOAVShPtbm+5Dc1TSZcaOrT958q9ISLuo+
	laRGxBkefmcRQjmWWreBPTGpSxHlGw5v7yQ3Wf
X-Received: by 2002:a17:906:7950:b0:a99:fe8c:5c6b with SMTP id a640c23a62f3a-a99fe8c889dmr675117666b.23.1728972385427;
        Mon, 14 Oct 2024 23:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjvvw7IStFnoxBVeCwZt8MlyalbexQktfbHHkmr3B3xG+RNKs3cQEUat2OoBHLmZKL1xiX4r+R0P/jma7aBqE=
X-Received: by 2002:a17:906:7950:b0:a99:fe8c:5c6b with SMTP id
 a640c23a62f3a-a99fe8c889dmr675115866b.23.1728972385129; Mon, 14 Oct 2024
 23:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-4-lulu@redhat.com>
 <acb5ea13-9695-4158-9152-aff761401be3@oracle.com>
In-Reply-To: <acb5ea13-9695-4158-9152-aff761401be3@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 14:05:47 +0800
Message-ID: <CACLfguVB0Xn2vsj6kJB9ONv1AhpcUteH9PEqDaPX-7JkxxqvKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function vhost_workers_free()
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 05:06, Mike Christie <michael.christie@oracle.com> wrote:
>
> On 10/3/24 8:58 PM, Cindy Lu wrote:
> > +static void vhost_workers_free(struct vhost_dev *dev)
> > +{
> > +     if (enforce_inherit_owner)
> > +             vhost_workers_free_task(dev);
> > +     else
> > +             vhost_workers_free_kthread(dev);
> > +}
>
> With patch 7, userspace could change enforce_inherit_owner after
> we created thread and we would call the wrong function above.
>
enforce_inherit_owner will only change before the owner was set.
the process is like set enforce_inherit_owner---->set owner->
thread/task creating
in in patch 7's code I have add the check for vhost's owner, if the
owner was set, the ioctl
to set enforce_inherit_owner will fail
Thanks
Cindy


