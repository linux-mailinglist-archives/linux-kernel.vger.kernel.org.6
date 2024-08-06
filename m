Return-Path: <linux-kernel+bounces-276196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF8948FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B785D2817A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B941C463D;
	Tue,  6 Aug 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep8RaX58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1851C462C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949145; cv=none; b=rLiBHyPEBMLhUlC7xjm8anyBc9wd/CAyfXHEXPjV3IhtXFgrpJ0J8xvUklxBL81urHntTjE+YxO83EhZyJvJDHU+EoZMXwI9maICRAiw+rXozupxs0froozSaZNqZITvjbVeeLtLQpbOotKfYQDMu0bTf+IRLk+aGEf3EAFNVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949145; c=relaxed/simple;
	bh=WRTEl+sMiGldjc/6bXsqZRJ/sl8EcbB0pjjcgi5eOnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9RlOqZ+MpiVTm8Ms5+nc1Vf0lnqdmzF2mxBf894oIm6U/oFshl2pJFKYlCYFsZM8YT8YnNbexfFOAZg4DhGdhUYtTVm5F7wLfVdnxqz0bKiB5j5x3ucwVV7Nzzq4Zz0iG80gZU0V8vqxbPam42ommEW+XjvdmTQH/Go8WjLmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep8RaX58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED608C32786;
	Tue,  6 Aug 2024 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722949144;
	bh=WRTEl+sMiGldjc/6bXsqZRJ/sl8EcbB0pjjcgi5eOnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ep8RaX588umdUmUXLx5Ecl9eEvX47YNAmIbVYHbQTjddP7hhN8RESSLm8qBqTxC2a
	 k04/3yPcH8nLyiGq5pVGelazPggWt2NSyeVNfoQ3swNmK33MgaD9ZVCYC2Y6xPPZ0m
	 f5wpcsjveio4ADHrQPIgaHAugiXHmzHhWYBwgV3A/8L/qMKGGBL6Td0f866TjjrY5q
	 9I7Sl2im7O/9/+nDA0Q3dP2yYghsWpfxyTkJduOG5KzpW0Ug9/ddbVCI64akiIQHxZ
	 UhmAixa1/lBNLzqpKl+/OgmbXLzzLAn1+oZ1C7pFSZWvo4szdCO2IsYZD8g89Fu5/0
	 c7VTb9knXrq7w==
Date: Tue, 6 Aug 2024 14:58:56 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240806145856.106c7ebe@foz.lan>
In-Reply-To: <20240806145153.0e1a70a9@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
	<20240806145153.0e1a70a9@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 6 Aug 2024 14:51:53 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +{ 'struct': 'CommonPlatformErrorRecord',
> > +  'data': {  
> 
> > +      'notification-type': 'str',  
> 
> this should be source id (type is just impl. detail of how QEMU delivers
> event for given source id)
> unless there is no plan to use more sources,
> I'd just drop this from API to avoid confusing user.
> 
> Since the patch comes before 5/7, it's not clear how it will be used at this point.
> I'd move the patch after 5/7.

As described at:

> +# @notification-type: pre-assigned GUID string indicating the record
> +#   association with an error event notification type, as defined
> +#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header

This is actually GUID of the error to be generated. Perhaps the better would
be to change the above to:

	{ 'struct': 'CommonPlatformErrorRecord',
	  'data': {
		'guid': 'str',
		'raw-data': 'str'
	}

Making it even clearer. In any case, this is mandatory, as otherwise
the interface would be limited to a single type.

Thanks,
Mauro

