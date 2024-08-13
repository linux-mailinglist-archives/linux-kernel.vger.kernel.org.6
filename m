Return-Path: <linux-kernel+bounces-284496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AEA95019C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68931C21E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB35B18953E;
	Tue, 13 Aug 2024 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="afGbdhom"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58317BB2F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542729; cv=none; b=C8nXyy2Pdc84h7sU2GDwgaDtFdv+SX57QL5LLPw9j36aNMj8OtHXtDHmW3pLEwR9lDHUGmtIWMhWdygUq1APZbuDkbsUQLMARJtE5cbqFpmXMtE+rxutiq+slwOJdADqezewMD3Lxgx+ah+iO5HGon0Dhk7FgmPxrlTW8Sj+yWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542729; c=relaxed/simple;
	bh=OkL5HlrIiWFlAVdVzfNDjV+VmwU0wKt2n2UcF0Sf2Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bod0XRVKJGTkmYuDumxfdmrd0q+qGEUv8d+N2F2bku1MM+Z7UniDouWE4Gb6lMP0qXm//6plth6tQNzIax/9y/iI/7tbPN2sA/alZiiEcski7jrhl741jzemlnNakJ5ezTiRiPzeqIogEWInkwKm7mHOw9Sh07eY6znxXjmNqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=afGbdhom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF46EC4AF10;
	Tue, 13 Aug 2024 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723542729;
	bh=OkL5HlrIiWFlAVdVzfNDjV+VmwU0wKt2n2UcF0Sf2Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afGbdhomdWetESGojIU9PLjWBg87BM1aCLDYgPtnqKEMqDXet2Y3DKmRQjRulW93T
	 aZw4nAebCx4mU1Ovbg8gWs+r7GCTXkJK01M94Bn5rXREKuk+KoBLtzs6ebJN+hwEGo
	 JIMMAxo0SUysiEt99BSO08euIFvr0Ea0i2Z81Z4Y=
Date: Tue, 13 Aug 2024 11:52:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2] drivers/base: Introduce device_match_t for device
 finding APIs
Message-ID: <2024081322-moneyless-gruffly-c540@gregkh>
References: <20240811-dev_match_api-v2-1-dd22ff555a30@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811-dev_match_api-v2-1-dd22ff555a30@quicinc.com>

On Sun, Aug 11, 2024 at 10:15:16AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> There are several drivers/base APIs for finding a specific device, and
> they currently use the following good type for the @match parameter:
> int (*match)(struct device *dev, const void *data)
> 
> Since these operations do not modify the caller-provided @*data, this
> type is worthy of a dedicated typedef:
> typedef int (*device_match_t)(struct device *dev, const void *data)
> 
> Advantages of using device_match_t:
>  - Shorter API declarations and definitions
>  - Prevent further APIs from using a bad type for @match
> 
> So introduce device_match_t and apply it to the existing
> (bus|class|driver|auxiliary)_find_device() APIs.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Git rebase over the following commit:
>   bfa54a793ba7 ("driver core: bus: Fix double free in driver API bus_register()")
> - Link to v1: https://lore.kernel.org/r/20240802-dev_match_api-v1-1-51e16d3bf031@quicinc.com
> ---
>  drivers/base/auxiliary.c      | 2 +-
>  drivers/base/bus.c            | 2 +-
>  drivers/base/class.c          | 3 +--
>  drivers/base/driver.c         | 2 +-
>  include/linux/auxiliary_bus.h | 2 +-
>  include/linux/device/bus.h    | 5 +++--
>  include/linux/device/class.h  | 2 +-
>  include/linux/device/driver.h | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 54b92839e05c..7823888af4f6 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -352,7 +352,7 @@ EXPORT_SYMBOL_GPL(__auxiliary_device_add);
>   */
>  struct auxiliary_device *auxiliary_find_device(struct device *start,
>  					       const void *data,
> -					       int (*match)(struct device *dev, const void *data))
> +					       device_match_t match)
>  {
>  	struct device *dev;
>  
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index abf090ace833..657c93c38b0d 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -391,7 +391,7 @@ EXPORT_SYMBOL_GPL(bus_for_each_dev);
>   */
>  struct device *bus_find_device(const struct bus_type *bus,
>  			       struct device *start, const void *data,
> -			       int (*match)(struct device *dev, const void *data))
> +			       device_match_t match)
>  {
>  	struct subsys_private *sp = bus_to_subsys(bus);
>  	struct klist_iter i;
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 7b38fdf8e1d7..ae22fa992c04 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -433,8 +433,7 @@ EXPORT_SYMBOL_GPL(class_for_each_device);
>   * code.  There's no locking restriction.
>   */
>  struct device *class_find_device(const struct class *class, const struct device *start,
> -				 const void *data,
> -				 int (*match)(struct device *, const void *))
> +				 const void *data, device_match_t match)
>  {
>  	struct subsys_private *sp = class_to_subsys(class);
>  	struct class_dev_iter iter;
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 88c6fd1f1992..b4eb5b89c4ee 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -150,7 +150,7 @@ EXPORT_SYMBOL_GPL(driver_for_each_device);
>   */
>  struct device *driver_find_device(const struct device_driver *drv,
>  				  struct device *start, const void *data,
> -				  int (*match)(struct device *dev, const void *data))
> +				  device_match_t match)
>  {
>  	struct klist_iter i;
>  	struct device *dev;
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index 662b8ae54b6a..31762324bcc9 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -271,6 +271,6 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv);
>  
>  struct auxiliary_device *auxiliary_find_device(struct device *start,
>  					       const void *data,
> -					       int (*match)(struct device *dev, const void *data));
> +					       device_match_t match);
>  
>  #endif /* _AUXILIARY_BUS_H_ */
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 807831d6bf0f..970de5ee5562 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -126,6 +126,8 @@ struct bus_attribute {
>  int __must_check bus_create_file(const struct bus_type *bus, struct bus_attribute *attr);
>  void bus_remove_file(const struct bus_type *bus, struct bus_attribute *attr);
>  
> +/* Matching function type for drivers/base APIs to find a specific device */
> +typedef int (*device_match_t)(struct device *dev, const void *data);
>  /* Generic device matching functions that all busses can use to match with */

Extra new-line after the typedef please.

And shouldn't this be in device.h instead?

thanks,

greg k-h

