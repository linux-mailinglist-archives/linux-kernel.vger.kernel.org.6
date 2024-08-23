Return-Path: <linux-kernel+bounces-299074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEE895CFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5304B282BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498CC188A23;
	Fri, 23 Aug 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JM1Zh8FO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FCC17E01F;
	Fri, 23 Aug 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422218; cv=none; b=CrwQ+fhn+k23ZD63YzEX0PzRYhPvuO6PznQqEepGM2P/3YqY+PuuAxHeQcJZ56PsGzcrI+aXJzBerp61/P/m9LxNWRERsgScVXtP33hzJZEipFSO9qk4J90tSEb0etQoEyXm5LdfHljYqdfZfT+gbxE2bBPU1RyiesQtsLszguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422218; c=relaxed/simple;
	bh=VzqXcNJ759Uw818gSbn6I73cmLxqgn7iNqCDboRjbAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1Ji8TK6H9LnVF17o8Xan72WZqmbxPvqtgcOABBLLoNbGzPfPL4YJzjSC7jqD8Qn3zXkCG0319SYk2xOkVjIJbU0POZKebHLloKVIJJKEk92k9igIXWxggHh9PoXNCjYNuwzmgo3hp6LdBAHoEhCOZS5fPFnbCqOfe5ViDomyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JM1Zh8FO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724422217; x=1755958217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VzqXcNJ759Uw818gSbn6I73cmLxqgn7iNqCDboRjbAk=;
  b=JM1Zh8FOP+tWF9h2fYWY4/LF9kw6ss1Hb6BrKLOd2wTaF65wLpRvPaXm
   csAmJxK+npRaCM6imbASVIylV8J/uJMsdQF/1jPAWIScMhux17wXhqHnE
   weVQnnxziKTfgnptRh30hesQFOQLjHN/GRZj4OIYLPBH9x7I/O0pnegQZ
   qrLlG9FtbW+LbQPTcmUZOD/LpB33tkkGOoUQp9r494pswl34ES7PelnPi
   W9Y1WKMn578zrHDyvUWlVIzmA3DmVG/Dil+no+udpbz2PE7aUTkpykXKv
   DjrTRp/ZC9doM27bkrPfgcyoIJvL77GBHTs7OcPxij8hLrdIeuQIX7HwD
   g==;
X-CSE-ConnectionGUID: K4xJo2oVRNySujoRfosK/A==
X-CSE-MsgGUID: 9EsboOftSu+KuUhVyYwIxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34270419"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="34270419"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:10:16 -0700
X-CSE-ConnectionGUID: wCFesym4TmKvBgkwOXW/zQ==
X-CSE-MsgGUID: fmOD+iE2TcaOQ418eE3lkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61825177"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa009.fm.intel.com with SMTP; 23 Aug 2024 07:10:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 23 Aug 2024 17:10:12 +0300
Date: Fri, 23 Aug 2024 17:10:12 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kyletso@google.com, rdbabiera@google.com
Subject: Re: [PATCH v3] usb: roles: add lockdep class key to struct
 usb_role_switch
Message-ID: <ZsiYRAJST/2hAju1@kuha.fi.intel.com>
References: <20240822223717.253433-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822223717.253433-1-amitsd@google.com>

On Thu, Aug 22, 2024 at 03:37:15PM -0700, Amit Sunil Dhamne wrote:
> There can be multiple role switch devices running on a platform. Given
> that lockdep is not capable of differentiating between locks of
> different instances, false positive warnings for circular locking are
> reported. To prevent this, register unique lockdep key for each of the
> individual instances.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v1->v2
> - Avoid usage of ifdefs.
> v2->v3
> - Removed redundancies.
> - Completed peer review and added reviewer signature.
> ---
>  drivers/usb/roles/class.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index d7aa913ceb8a..7aca1ef7f44c 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -11,6 +11,7 @@
>  #include <linux/usb/role.h>
>  #include <linux/property.h>
>  #include <linux/device.h>
> +#include <linux/lockdep.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> @@ -33,6 +34,8 @@ struct usb_role_switch {
>  	usb_role_switch_set_t set;
>  	usb_role_switch_get_t get;
>  	bool allow_userspace_control;
> +
> +	struct lock_class_key key;
>  };
>  
>  #define to_role_switch(d)	container_of(d, struct usb_role_switch, dev)
> @@ -396,6 +399,9 @@ usb_role_switch_register(struct device *parent,
>  
>  	sw->registered = true;
>  
> +	lockdep_register_key(&sw->key);
> +	lockdep_set_class(&sw->lock, &sw->key);
> +
>  	/* TODO: Symlinks for the host port and the device controller. */
>  
>  	return sw;
> @@ -412,6 +418,9 @@ void usb_role_switch_unregister(struct usb_role_switch *sw)
>  {
>  	if (IS_ERR_OR_NULL(sw))
>  		return;
> +
> +	lockdep_unregister_key(&sw->key);
> +
>  	sw->registered = false;
>  	if (dev_fwnode(&sw->dev))
>  		component_del(&sw->dev, &connector_ops);
> 
> base-commit: ca7df2c7bb5f83fe46aa9ce998b7352c6b28f3a1
> -- 
> 2.46.0.184.g6999bdac58-goog

-- 
heikki

