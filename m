Return-Path: <linux-kernel+bounces-319406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2396FC2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8D72862A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD81D3634;
	Fri,  6 Sep 2024 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcsdiJ1X"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13CA1B85FB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651075; cv=none; b=s+G573XUDzQKSpZjiZrjBiosNL+M0fFf4seAuP6G+qIDTutXGcRHXmXaZv4/Ge8GkR7B5QdQZiTR9MlVKEfN7HjmB7bHiYnyR8H5IY6v2yPb+Sm30VcZ1tJpZCjcl1j7kpui93IEGr0Lg7ow1fn5X/LAyQTvQGBz8XX6FHW348o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651075; c=relaxed/simple;
	bh=98O+mHWBCrwkb1Hu1r6S00THAU1t0ISFTYgtXw/8kuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7PGaInpfhQCnCLQ7JAWdhE4VP6sO+/FZdgFf0g5RsRHeHPoFkpaGV0ZIPG0JeVwbkxD3rCFAB+fDntP4jFvgal0wH3wYXIkz2S7lwh249Wd3S3+zLYcWU3hTscKdBD608kpEqXyIxH6MucoeARUDtr0VKUpKu7nkGB8xAJw0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcsdiJ1X; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f4f2868621so27393431fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725651072; x=1726255872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU6fY42HxjMHwn9M1PhjICuTtsea/6zud/1cFxYT38k=;
        b=DcsdiJ1X3MiOxpQK8+C48U0DsJyOoVBxV+vd8QwUbSia28GLvD9iUiSvm4PUb0Ps/P
         djld2HBT2p9zTY3rgjtbCYjwooVwQXQXDHs2c71JJ02KIw9KJIdXfIRzkyLX7wwcs5y4
         J8sqiNwNb8MOBUfasQr3V8cmp6t1iHIuT47WjAi/elFvZivaeqQvdbCd9LviA820hBbn
         BwRaXwQQqVbXmEOsvo/3keUzS7DQJnAupknFxApc4CBCSucynJTcFi0ft7nZIn9UY4Gw
         Ccgy17bu0mFfEXvC+HGFSxJXq+WWDzh4TVGmQ3zkJymvtM2qMAv4HaIgfE7BrAygzpnB
         YMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651072; x=1726255872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kU6fY42HxjMHwn9M1PhjICuTtsea/6zud/1cFxYT38k=;
        b=QQqm+OtWDAJUQDTika1LP8mktx0f4Qxa8xxLDrTHplMNNGyMZZlFW+GWDwllY9ln5G
         jO0Ji1Iv1eyhYz2QAA6vizUzlS14dBBKVLBOc1LHhWyjoHQ7VObKS926FxP3qGffvzI5
         j8Nk8L/KDQsB2TFJZosTzpnRlZmA+8ID510IBTW7G6FuaqivIN12nsriyHjD7I3Z4jkk
         ufiwMh78Myu0963sZ2Rhb1jQOphFBsSWV+2f+snru9z/Q/1aJCD20u7mSU5DpD8Zz22p
         ALxbVCS7IQfu0JGyFzQsjBdg4Q+z99kv3MlMdI+FjvJGVXzMxqbPkgm1LKzkzG3Hf43J
         SwNA==
X-Forwarded-Encrypted: i=1; AJvYcCXyxKVuveKJhqRU97+kzwrDy92ppddzIFdsBWeb4/XMmd6dPxdhGE+j6gPcs3GjmT6FJyFbrGSimmn9zj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2X3i5IZFyWN4UUV6B7P9Xt+KXNMW1ePKRzK/uY/Zsrehxngsn
	p/BhUoUOpcNsCQ9EZm6qzX/5qD/8BKaToC+zeNobrYSD82Fjjm61bNurQt6bZ1fuspCMzI7pix9
	tajOpvVociVTZy9tQjajKfepurL4=
X-Google-Smtp-Source: AGHT+IHozveXLLlaeMtebjuOMmEiUzPWhdK+f3KapkCj8+YNnkeoTW1w48uuLFjYiCSxq1qs/waknZ1yKxe2+UT7HA4=
X-Received: by 2002:a2e:bc21:0:b0:2f3:aed8:aa9b with SMTP id
 38308e7fff4ca-2f751eaef7emr22940111fa.5.1725651070968; Fri, 06 Sep 2024
 12:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-3-suravee.suthikulpanit@amd.com> <66db2589.170a0220.6f57.d691SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <66db2589.170a0220.6f57.d691SMTPIN_ADDED_BROKEN@mx.google.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 6 Sep 2024 21:31:06 +0200
Message-ID: <CAFULd4b=jUUPk3ZEzyfkeCZLOkQT9OXaM_Vx1Okw-00xwcU7bA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, joro@8bytes.org, robin.murphy@arm.com, 
	vasant.hegde@amd.com, jgg@nvidia.com, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 5:53=E2=80=AFPM Jacob Pan <jacob.pan@linux.microsoft=
.com> wrote:

> > +static void update_dte256(struct amd_iommu *iommu, struct
> > iommu_dev_data *dev_data,
> > +                       struct dev_table_entry *new)
> > +{
> > +     struct dev_table_entry *dev_table =3D get_dev_table(iommu);
> > +     struct dev_table_entry *ptr =3D &dev_table[dev_data->devid];
> > +     struct dev_table_entry old;
> > +     u128 tmp;
> > +
> > +     lockdep_assert_held(&dev_data->dte_lock);
> > +
> > +     old.data128[0] =3D ptr->data128[0];
> > +     old.data128[1] =3D ptr->data128[1];
> > +
> > +     tmp =3D cmpxchg128(&ptr->data128[1], old.data128[1], new->data128=
[1]);
> > +     if (tmp =3D=3D old.data128[1]) {
> If you are able to deal with the failure, why not use try_cmpxchg128
> for the hi 128 bit also? It is more efficient.

Indeed, just write:

if (try_cmpxchg128(&ptr->data128[1], &old.data128[1], new->data128[1])) {

to substitute the last two lines above.

Please also note that try_cmpxchg128() updates its second argument on failu=
re.

Uros.

