Return-Path: <linux-kernel+bounces-285583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660B7950FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2352B1F25978
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BED1AB524;
	Tue, 13 Aug 2024 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM341nC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3ED1AB512
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589549; cv=none; b=u3qW0K87NoeMl2z1x+vqVn3cla7xxFaK6wKuIfOY9ISuODP1FEl644xmJegRY4mqy8IkwmL/VKJukdY2CbP6MVmoVCr/7OFD+GfXiChvHKpOGWpZYagHJNtNUv180kDC3lRc+TKQgBwqYge+cWCrsSk51G/v00dhI8tMQbrYOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589549; c=relaxed/simple;
	bh=taGYQNtBhkBLngecX3rD0z1lOHvXGOPIG4tljyveswA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SX+OsDal6hOlX9wLtWJB7DrksXDgfemzCPJIdPBaQo6HfYicv4uPcF5B3NglfmmJ4idEtXcsqALJUWxm/UtyjybbMgNvrOFrDBCMEi3Y2kg3tRaaH0pLBv8okRpjr86Aq0SsSZNftU/o1U242nXy6OM3/iI+PK0D8Ek47cLbnNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM341nC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACF2C4AF0C;
	Tue, 13 Aug 2024 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723589548;
	bh=taGYQNtBhkBLngecX3rD0z1lOHvXGOPIG4tljyveswA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pM341nC8YVpHBt9jcYyq/lQ9kMmRvfSnJyukeluBc1PzhJ6jHSjgwHyFam3jLsFtJ
	 4raLd4dAlLq5ZVTGSI6z4Ocput8BmlH524Br9UzKH+FFIWQ2UD1t0guGzsWH1G177j
	 JqkK0X1ZK1ntfCYLNsByHqW97/YgF589IDTWsMhrK539XIT2C+5raJb8C99bc+tRa7
	 vFSROiZ3Yw3y47lCQwyqOM8593uYLizA8NpiO0q/2koc10z1j0+mQtVKYtv2yEV3bp
	 Ogiecxf3fpE4CrOk8jSXF8PzA8km5dI06vZQOMkicB+zBEUFbWdi6m1qS3fi59twH+
	 AUM3Jl8oU8dug==
Date: Wed, 14 Aug 2024 00:52:22 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 04/10] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240814005222.74f45f78@foz.lan>
In-Reply-To: <20240812135744.644deaa9@imammedo.users.ipa.redhat.com>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
	<87799362699e4349ce4a44f3d25698d5764735c6.1723119423.git.mchehab+huawei@kernel.org>
	<20240812135744.644deaa9@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 12 Aug 2024 13:57:44 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> n Platform Error Record - CPER - as defined at the UEFI
> > +# specification.  See
> > +# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
> > +# for more details.
> > +#
> > +# @notification-type: pre-assigned GUID string indicating the record
> > +#   association with an error event notification type, as defined
> > +#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
> > +#
> > +# @raw-data: Contains a base64 encoded string with the payload of
> > +#   the CPER.
> > +#
> > +# Since: 9.2
> > +##
> > +{ 'struct': 'CommonPlatformErrorRecord',
> > +  'data': {
> > +      'notification-type': 'str',  
> 
> like was mentioned at v5 review,
> you only need this for setting cper notification type if you are (re)using
> 
>   acpi_ghes_generic_error_status() && acpi_ghes_generic_error_data()
> 
> however while doing this in (6/10), you are also limiting what
> could be encoded in headers to some hardcoded values.
> 
> Given QEMU doesn't need to know anything about notification type,
> modulo putting it data block header, it would be beneficial
> to drop 'notification type' from QAPI interface, and include
> error status block and error data headers in raw-data.
> 
> This way it should be possible to change headers within python script
> without affecting QEMU and QAPI interface. On top of that
> ghes_record_cper_errors() could be simplified by dropping (in 6/10)
>    acpi_ghes_generic_error_status() && acpi_ghes_generic_error_data()
> and just copying raw-data as is directly into error buffer (assuming
> script put needed headers cper data).
> 
> From fusing pov it's also beneficial to try generate junk error status
> block headers, for which python script looks like ideal place to put
> it in.

Got it. Will change it to just:

{ 'command': 'ghes-cper',
  'data': {
    'cper': 'str'
  },
  'features': [ 'unstable' ]
}

where cper contains an base64-encoded string with the entire raw data
including generic error status end generic error data.

I'm moving the current defaults to the python script. Let's merge
this with the defaults there. The script can later be modified to
allow changing such defaults.

Thanks,
Mauro

