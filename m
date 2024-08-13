Return-Path: <linux-kernel+bounces-285535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99600950F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3D4281B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006C1A76DC;
	Tue, 13 Aug 2024 21:22:28 +0000 (UTC)
Received: from sxb1plsmtpa01-13.prod.sxb1.secureserver.net (sxb1plsmtpa01-13.prod.sxb1.secureserver.net [92.204.81.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCB1A704F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584148; cv=none; b=rQq8IUAaEce4iwkHdDGEIWvaSkQd3pCggUloUcTPpJWOiYZy58Hdm7wT7c0BIfDLhsq46oUs9oMqx65zod7VS5wsEVIu4x2OW3VRXZYZEbxlic4Zydb7iVnFPZWk++gTJps07Qwg22VIWztkwtv+rPsHec6xmXUOzBJu61XdLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584148; c=relaxed/simple;
	bh=mbq3NW0pnyyTeab8LcRnhlnEuHcGsvBM3EXVOrAD6/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zzb1KB36xNwMojAfYPmagikIhPGP5y3vtsy/xnNhVYTSOyuhdW6OsF3Log+D9aIMuCeiQkgb0iV8s7wRcvJH7Zh423vHoZA95MMvIC9wA+g0dQGYLKqRTkgh42S+RyMF9rrpHuFbPoj0TTslpN3iIT5JyuMTmsbdu5P10f0OZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=92.204.81.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from [192.168.1.27] ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id dyfnsVaaUn3BbdyfpsI01x; Tue, 13 Aug 2024 14:03:22 -0700
X-CMAE-Analysis: v=2.4 cv=AM9iEndf c=1 sm=1 tr=0 ts=66bbca1a
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=QyXUC8HyAAAA:8 a=t3YNmgBSAAAA:8
 a=p0AuB5x_3uX4-FXbu-EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ctH_qozkpUrkr3SVbfwb:22
X-SECURESERVER-ACCT: peter@piie.net
Message-ID: <626a39f9-f60f-4dab-8330-8cf68ecb7520@piie.net>
Date: Tue, 13 Aug 2024 23:03:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] thermal: gov_bang_bang: Call
 __thermal_cdev_update() directly
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
 <13583081.uLZWGnKmhe@rjwysocki.net>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
In-Reply-To: <13583081.uLZWGnKmhe@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfImXDGwrG2+7isMXPdh5dhYZU30JJWvh6U0alaylkFoI+YHbzq0QMiQRTkGop5fdtYeGFgmP+x7xLDo669CYQX9Kz4ZJWaYAs/azv4fH0lBcb4FzOSSe
 6wqx0HbImj+5ZlbNC72Mu2Jv/Uoqu8pYHdcD5WoHSQw+HyZBFh4FLOMlgN6O4hYJ/tvA46XdMUVqYfwLFf3XGHppX1iIZPrgA5hTZhxfyndQs+Xb0Nn7SglQ
 pNz1BDSbR9m6z/u5SMFu1WvC8b2fiU4vqlhZZmCKeSakKEplkvFf2Q0xg2lWwRshvIwchzxvpgJlLGzdlBcKJ9hxqDUXT5zzECFyjFdM3f9tywDZou5MzX/I
 MxT+3rZPKSLyzG9YIgJwAaDv0JUEKQ==

On 13.08.24 16:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of clearing the "updated" flag for each cooling device
> affected by the trip point crossing in bang_bang_control() and
> walking all thermal instances to run thermal_cdev_update() for all
> of the affected cooling devices, call __thermal_cdev_update()
> directly for each of them.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Peter Kästle <peter@piie.net>

> ---
>   drivers/thermal/gov_bang_bang.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -71,12 +71,9 @@ static void bang_bang_control(struct the
>   		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
>   
>   		mutex_lock(&instance->cdev->lock);
> -		instance->cdev->updated = false; /* cdev needs update */
> +		__thermal_cdev_update(instance->cdev);
>   		mutex_unlock(&instance->cdev->lock);
>   	}
> -
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> -		thermal_cdev_update(instance->cdev);
>   }
>   
>   static struct thermal_governor thermal_gov_bang_bang = {
> 
> 
> 

