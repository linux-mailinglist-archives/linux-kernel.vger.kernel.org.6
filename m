Return-Path: <linux-kernel+bounces-262014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A79093BF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2971F2292B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9C197A7E;
	Thu, 25 Jul 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7kAFTZ8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193D13BAEE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900907; cv=none; b=oNPF3qUj5guaU5q68K14oc8h1EF+aabDj1RZMe3SY5pUOeXZkyugCe6q62g212bBZjI3eHtd5Gvqu2o5EsaJ+SPROfvtNTVc3PcECYE/1PYgn/dmJsreNj7NZOUalhFdv/8pOQZKIFICCnGZ9LGV4Tu5T/dx7E80N9FjVMZxClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900907; c=relaxed/simple;
	bh=4MQ2bItKuzboFKrPHf4CEndTlYY2m55SrDHFV0/yZq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tRLp2qInOIznj9ri2lhYPE3+ik5I1AeAP32FErkVWcAWxzgRomDb/gnkktyFt5b/BviOSdA2Uzu3mNS/lE11+WWreUtTVbq7GLWedS0V58g/5rOOHR+wCCwYXQpKerQwNJqHnLBj8bmxCNIZ/y2hbRYc7rT+UoIa0HecA5yiRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7kAFTZ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721900904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1bce9JEpfXvcwePXavoFZ3558ZqzOQZ/t6vPIqba6Y=;
	b=B7kAFTZ8TSY3qHwvX5ot81FGv04GoIMwbP37145RNJLht66GsZenXP/6RXkaCme4EBuEmI
	uEUFowBo3rPo6V9XSkeDKObrqzX6PjM7dlXKRs1auyD8+UEEythKcKMQtdNnNTENyAsRpK
	cO8yySFMkt8yOChtEHb6oN71isA7SgM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-NUWNpbPPMmOT3hMEjMP8eg-1; Thu,
 25 Jul 2024 05:48:20 -0400
X-MC-Unique: NUWNpbPPMmOT3hMEjMP8eg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8EA91955D4A;
	Thu, 25 Jul 2024 09:48:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1577019560AE;
	Thu, 25 Jul 2024 09:48:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E0EB521E6682; Thu, 25 Jul 2024 11:48:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Shiju Jose
 <shiju.jose@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Ani
 Sinha <anisinha@redhat.com>,  Dongjiu Geng <gengdongjiu1@gmail.com>,  Eric
 Blake <eblake@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  linux-kernel@vger.kernel.org,
  qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
In-Reply-To: <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
	(Mauro Carvalho Chehab's message of "Mon, 22 Jul 2024 08:45:56 +0200")
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
Date: Thu, 25 Jul 2024 11:48:12 +0200
Message-ID: <87bk2lreeb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> 1. Some GHES functions require handling addresses. Add a helper function
>    to support it.
>
> 2. Add support for ACPI CPER (firmware-first) ARM processor error injection.
>
> Compliance with N.2.4.4 ARM Processor Error Section in UEFI 2.6 and
> upper specs, using error type bit encoding as detailed at UEFI 2.9A
> errata.
>
> Error injection examples:
>
> { "execute": "qmp_capabilities" }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error']
>       }
> }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['tlb-error']
>       }
> }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['bus-error']
>       }
> }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error', 'tlb-error']
>       }
> }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error', 'tlb-error', 'bus-error', 'micro-arch-error']
>       }
> }
> ...
>
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> For Add a logic to handle block addresses,
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> For FW first ARM processor error injection,
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  configs/targets/aarch64-softmmu.mak |   1 +
>  hw/acpi/ghes.c                      | 258 ++++++++++++++++++++++++++--
>  hw/arm/Kconfig                      |   4 +
>  hw/arm/arm_error_inject.c           |  35 ++++
>  hw/arm/arm_error_inject_stubs.c     |  18 ++
>  hw/arm/meson.build                  |   3 +
>  include/hw/acpi/ghes.h              |   2 +
>  qapi/arm-error-inject.json          |  49 ++++++
>  qapi/meson.build                    |   1 +
>  qapi/qapi-schema.json               |   1 +
>  10 files changed, 361 insertions(+), 11 deletions(-)
>  create mode 100644 hw/arm/arm_error_inject.c
>  create mode 100644 hw/arm/arm_error_inject_stubs.c
>  create mode 100644 qapi/arm-error-inject.json

Since the new file not covered in MAINTAINERS, get_maintainer.pl will
blame it on the QAPI maintainers alone.  No good.

[...]

> diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
> new file mode 100644
> index 000000000000..430e6cea6b60
> --- /dev/null
> +++ b/qapi/arm-error-inject.json
> @@ -0,0 +1,49 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# = ARM Processor Errors
> +##
> +
> +##
> +# @ArmProcessorErrorType:
> +#
> +# Type of ARM processor error to inject
> +#
> +# @unknown-error: Unknown error

Removed in PATCH 7, and unused until then.  Why add it in the first
place?

> +#
> +# @cache-error: Cache error
> +#
> +# @tlb-error: TLB error
> +#
> +# @bus-error: Bus error.
> +#
> +# @micro-arch-error: Micro architectural error.
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'ArmProcessorErrorType',
> +  'data': ['unknown-error',
> +	   'cache-error',

Tab in this line.  Please convert to spaces.

> +           'tlb-error',
> +           'bus-error',
> +           'micro-arch-error']
> +}
> +
> +##
> +# @arm-inject-error:
> +#
> +# Inject ARM Processor error.
> +#
> +# @errortypes: ARM processor error types to inject
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 9.1
> +##
> +{ 'command': 'arm-inject-error',
> +  'data': { 'errortypes': ['ArmProcessorErrorType'] },

Please separate words with dashes: 'error-types'.

> +  'features': [ 'unstable' ]
> +}

Is this used only with TARGET_ARM?

Why is being able to inject multiple error types at once useful?

I'd expect at least some of these errors to come with additional
information.  For instance, I imagine a bus error is associated with
some address.

If we encode the the error to inject as an enum value, adding more will
be hard.

If we wrap the enum in a struct

    { 'struct': 'ArmProcessorError',
      'data': { 'type': 'ArmProcessorErrorType' } }

we can later extend it like

    { 'union': 'ArmProcessorError',
      'base: { 'type': 'ArmProcessorErrorType' }
      'data': {
          'bus-error': 'ArmProcessorBusErrorData' } }

    { 'struct': 'ArmProcessorBusErrorData',
      'data': ... }

> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..5927932c4be3 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -22,6 +22,7 @@ if have_system or have_tools or have_ga
>  endif
>  
>  qapi_all_modules = [
> +  'arm-error-inject',
>    'authz',
>    'block',
>    'block-core',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..479a22de7e43 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -81,3 +81,4 @@
>  { 'include': 'vfio.json' }
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
> +{ 'include': 'arm-error-inject.json' }


