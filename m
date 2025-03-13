Return-Path: <linux-kernel+bounces-559320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB37A5F24B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFE217CFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90F62661BE;
	Thu, 13 Mar 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Goipk6yy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642122661A0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865176; cv=none; b=lQA9sk6mUAtlREoza2qysGt3btA0gqy6xy0aJNviTWkTj8vT9YgWOD4jkcuSd9UJGqQZP4a5z67JQTbsEWFDp56jmbDHNRXYiqIMTlcgqEIdZ6MLBAEqxrIpI+dMFK5TBoJyBm6ZvpH8I/okX7PI5nZtp/tk0SCKbUrxvoK6hww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865176; c=relaxed/simple;
	bh=j8JKeL3My3p380xaKx7CR7AkatM+RkoyVjF5AKF9V/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XROcXUtTj7585UBoq4WbxfIVOiwC6ybXRRb7Xj4amMa/BcTbksLdEi3gKfUh0WJrZ+LyDyRyccC50lRVWGjLGxMVzgFvn7wLO8XpIUhEIb1KRBeFW+yYURCc/IgAmw2pwX4hBV2mtJN8FllSixkesViub910Tt0M0hp9PFjbNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Goipk6yy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741865173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=haq21k8jWN6ck+QB/yq8TbL/zWBVpjmfQO2fprJtAqs=;
	b=Goipk6yyCBvyiEucUCgDLtQrHtHhHffFpE32KhbNmJHjRGPLPQpMPbfPW0EGjDVbKnGO5n
	guX4SVakDVNYlN6n1fPcJbHuh72z/B7J2keW1o6pNaEziMrbaoO7Cvc02sR2hepvXt2E84
	pQGvKLB5zwSo5eqcdlX+Ymlw7QsgAzs=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-6f9i32QIP0maV_s1-erOJQ-1; Thu, 13 Mar 2025 07:26:12 -0400
X-MC-Unique: 6f9i32QIP0maV_s1-erOJQ-1
X-Mimecast-MFC-AGG-ID: 6f9i32QIP0maV_s1-erOJQ_1741865172
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-86d33b8ead3so195377241.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865171; x=1742469971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haq21k8jWN6ck+QB/yq8TbL/zWBVpjmfQO2fprJtAqs=;
        b=Szh2QHkankZWr0SE207QC16qEJtPvoglI4uK3Jqr/TjoO7vkl19UEQ12dYMI3AYALx
         fhml+U6Y2odVqZBZpoO3cShVTJkx1zxFuG0FJtmMZM3Ed5QoGLcC42N0nEykSapkLm2B
         o3xRK5lhxGIv7MUng17kDnqC9f0eFgdgluWJVR9F0J12GZ8fQs5LvVrwoPpDLQXzaMIm
         6ZuGdVq9zzMd4EWbPMvP50PyIrH09UQOBpmyZev4DZv1CF4Sc4Pu7DAvuPlxg8I4nINV
         NAL2M8mXxTnid9LWH0hlbmq/oATM+A9e1XmdOXITWpZtJxVKxxhKJsG+UOMHllVSjs44
         by7w==
X-Forwarded-Encrypted: i=1; AJvYcCVfuKGsfvsK6H7iiEuF2Qvbd7IjNJItlwh9x1aO0KSYR4ksOQN/iOoEiZ1iLit8d9b8PXYRkJLi4wlqO0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMK4eTvfUUNMijbub7caxKBrYvR8JqGaeYxYRAigXPPRxx3MiK
	aovybDM0aLGvKsfYtunrb2mQ6h0DMqPRJ8iNMQFh4kHG+KIzvf0ouNjHgarG+wvRw4brmJzw7JM
	TxOAOsxFNGvzmMJ2g/reMDhjGCdwbMgEr+PMG513OMYhrrcFUkZ65Hz+3HnXG0swOg3yNffTq3w
	WuczZBe+pZd4L2K7PlgTXrYB6lKFIqv1ZZ2QNC
X-Gm-Gg: ASbGnctlWzzc1fjcLOzT+DLoQCIOH0eR3qHm8ylQ7PjkF2cb2/LJw3MdvAXpwK4p7VF
	9hc6BLt7pDSxN00sHa+mhhVGfNoNfGI9YtFea/fmZSNr3B/IZiQNaWQmhu2Tpdf4vGs/gr3wd
X-Received: by 2002:a05:6102:8001:b0:4bb:e8c5:b149 with SMTP id ada2fe7eead31-4c30a5ab186mr20926961137.7.1741865171667;
        Thu, 13 Mar 2025 04:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5cD6PF7kl5NUY7q/OW1oKX5tNdN8eFO7rQ/PRbWr3pjIaSRJ9butzW+C+5ydIiGErfk+O9f+OrAd/60RAi1M=
X-Received: by 2002:a05:6102:8001:b0:4bb:e8c5:b149 with SMTP id
 ada2fe7eead31-4c30a5ab186mr20926938137.7.1741865171411; Thu, 13 Mar 2025
 04:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1243044.1741776431@warthog.procyon.org.uk> <458de992be8760c387f7a4e55a1e42a021090a02.camel@ibm.com>
 <1330415.1741856450@warthog.procyon.org.uk>
In-Reply-To: <1330415.1741856450@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 13 Mar 2025 13:26:00 +0200
X-Gm-Features: AQ5f1Jo_X07BVCwtYl8dAOwfTVb-Lg71an6NgYoZsp8YoSb8JBQQYJu-cs0jBDU
Message-ID: <CAO8a2ShNtAGnaHpf8vj_vqgkw4=020cLn8+wQ9ovOO_5zDBK7g@mail.gmail.com>
Subject: Re: [PATCH] ceph: Fix incorrect flush end position calculation
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm sure @Ilya Dryomov will pick this up, this doesn't look urgent.

On Thu, Mar 13, 2025 at 11:00=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Shall I ask Christian to stick this in the vfs tree?  Or did you want to =
take
> it through the ceph tree?
>
> David
>


