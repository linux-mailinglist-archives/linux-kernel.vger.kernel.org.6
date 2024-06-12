Return-Path: <linux-kernel+bounces-211047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98333904C83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4328C1F2438C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF197169ACF;
	Wed, 12 Jun 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzwRu+MR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01928399
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176555; cv=none; b=I+iDmSqoSpe4auRWQRk0Ql5xF2ba6yhuQr4jmu2z6ZPEzfoqZSjoxd7LiVvhIikrLm8rTAEZgEo1hhAvp1CSVjXif2weIiuJfg2b1Xr4eRsV5i36j6BC6MpnlxKyLdqDmpdXvgA27Dub5hRPauLH08DZpkaUX6qyqmSq4g7k/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176555; c=relaxed/simple;
	bh=+ykbfSP9QE6LjsxeHl6HZt6oWo4XQ54KD3PrDqCfUic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPkwZsoI4h05M2bTVBl2Y8LaujPaASDZyDFa7ytS8UqGbfSG1jYsiiImaQJw8YEQQsGQ1HG+LSfWBLEFs1ZKdHTDkYXIiYmODu6+A2WqCvmG59teOf5rSUXuWkg4PJQ+tLumpeMOAUJh1aOYqUjfXlJRM3gr81Lrm/nnag3hauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UzwRu+MR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718176552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRPQpXge3I0Vcd7b2iojqZfH1RINuN+3D+5eFcM1E+A=;
	b=UzwRu+MRIjiIizxRMp5OqewHhA2+CyagLqf5Fp2YzIfw0eSKM4qSDE/N9yMWrYNJIye4Sr
	m+DbHmm9kHNONNxRIQaoFGOCgUvAkqBjIljryal99TRSeBtpY0y1cDgEi81xR5+q2vPe6Y
	DkTMbt8APsCFp7+6RxHIf2ALmwyfK80=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-MPisvdV5MUez0E_oJj-ZhQ-1; Wed, 12 Jun 2024 03:15:51 -0400
X-MC-Unique: MPisvdV5MUez0E_oJj-ZhQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1ddd8a47so1873202f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176549; x=1718781349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRPQpXge3I0Vcd7b2iojqZfH1RINuN+3D+5eFcM1E+A=;
        b=Zmc1DHYqvmQwIVYaHTx+20uVPKXT1P28slpOM+/fpeKw01HD9beMMA8t9St31FCNVH
         zG8bt1tHqJWhr7iOeeFucD7saKTFs2NK5rOY/XYyXIeDhCp5ubhXd00Q+UXZnCOLPNt4
         KGA4cxbqbhzzzenYZD3PPvyPVFwXbcZnpH+UsVp/30spaNYYHCg3zKoZoCOscivHl3iW
         pgkk1eqvEmA/MlvM/id3me/3XRE5aYsfYTCpivI3FXMhfv1rqXIXFkpiQtyDMgioXIGm
         X/24QqTpv1S5DjRyKJ/828d218vg/7TzNe1hgMNnUDAALi+H4nxqNd2WQVUi0xqZGTOW
         4xgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7bREj+g+HA+7gaBv7vluMh0kUGpqSKTL2RNp682zCsMtaKwXh8KpTJc6LBR8/CPGnAsVD0cwLYKLc62EWeZHzHsHtVQXYwLP0zEzb
X-Gm-Message-State: AOJu0YwJBmqvwzgUCxJPh5QCezOPWJrHjnDRmCzZKvUG+CcFiVWjpCg+
	Q5PaLf9y3Up9LFEcuVUf4RjSRjXZHPHf9Tm1IbFvu9B6iQ5PYkP8cSlBEnlYidAoGSwtVyuulKF
	g6dAAq/RC8N3dRo8dQa+mFhuqRZuDBQfLwUFGEUG31chdzJWfwYx1wcKCq6AtLI2sFKLYUA==
X-Received: by 2002:a5d:5288:0:b0:35f:18ad:bccb with SMTP id ffacd0b85a97d-35fe1bfda3fmr603593f8f.35.1718176548721;
        Wed, 12 Jun 2024 00:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYuQ+XjKBy6z8bjJ/5ejaRe3tBk9OjBlBGeQH9fUUBsA31Sgruib/67gZGeejF7RYzsndo1w==
X-Received: by 2002:a5d:5288:0:b0:35f:18ad:bccb with SMTP id ffacd0b85a97d-35fe1bfda3fmr603573f8f.35.1718176548189;
        Wed, 12 Jun 2024 00:15:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:39eb:4161:d39d:43e6:41f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f23a651d4sm7641411f8f.50.2024.06.12.00.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:15:47 -0700 (PDT)
Date: Wed, 12 Jun 2024 03:15:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240612031356-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>

On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> Add new UAPI to support the mac address from vdpa tool
> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> MAC address from the vdpa tool and then set it to the device.
> >> 
> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> >Why don't you use devlink?
> 
> Fair question. Why does vdpa-specific uapi even exist? To have
> driver-specific uapi Does not make any sense to me :/

I am not sure which uapi do you refer to? The one this patch proposes or
the existing one?



-- 
MST


