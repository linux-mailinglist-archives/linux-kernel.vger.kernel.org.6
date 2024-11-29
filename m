Return-Path: <linux-kernel+bounces-417640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51C9D56FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44BFB20D96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA583134A8;
	Fri, 22 Nov 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LY91NivH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052715A8;
	Fri, 22 Nov 2024 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732237730; cv=none; b=IxIiLhCmPg8SqYEWnJXC6psJf6UpqHu1Eb0zGHeLu+RX0rqOkXgCLrxm0CFhmb4K+r3PzKPBM47zAh9D9+CI/pWwCuLJuFVn63LmvZYQmf39WWD1hXfCCA+VOznT0+lPDAOo+osv+Kw8NAuNf6Lr0CEALImbqXhiqCAF5o4LPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732237730; c=relaxed/simple;
	bh=jhYwikW1Url89TiDvvAmv5w1/pKsItbY/I5GPgR9L14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iJcVp+fwPh2qmG8sT0ITzNVLTvHrDD3FFeXiY76BwsXzFADTZ1H30XzoRaQfEz8kSCTLcTQdg9zNZrh5XUF4nHZQO084v0mb8R3dUK0Aa/ksJBBIkyM2Ql0t/ZeURYAGzpJP/oTcm+2bNUMt2BmvnlfmCJs+gS5/0qfGytUOsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LY91NivH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALKLl9R019613;
	Fri, 22 Nov 2024 01:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CWkfbdcfi4qpzHtVx7PDZX4unstRH0VtK+pCtcuV8dk=; b=LY91NivHM2Ek8s/A
	NyFRW+FCuoFrf+quso0vbLQ3gdMMLq0jMdG9Q+tdGcK2+W2NVCv0l7eJFrBK3YTf
	IsjYw8UhFr3Fk/1/VPBV3PgLByljVRxWm6BIPY2cBhStO/j69fdtoZ1G2uRBW8/J
	kHOmWenEEUNSooP3MdeQlsOb7NudHSNvBUeENKwMh/CdU9T82Atroj79LccaHzxx
	tS71QwVUkMZbFXFNRNnHFdcISyRSu0+liTrP6Sn74R+wx0l85dwg+u+z67cYngOB
	fAueVgBXSsClpOdcEgNp37opEjpGsHCyyQ8djRdXPaPMDsep19j8xkd9tj/OVFAP
	rXwKzQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431c7hnu5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 01:08:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AM18j7E015313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 01:08:45 GMT
Received: from [10.4.85.44] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 17:08:43 -0800
Message-ID: <3ab115bf-7ac6-452f-b760-0d631b6e75dd@quicinc.com>
Date: Fri, 22 Nov 2024 12:08:41 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] tee: introduce orphan tee_shm and default context
To: Jens Wiklander <jens.wiklander@linaro.org>
CC: Sumit Garg <sumit.garg@linaro.org>, <op-tee@lists.trustedfirmware.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241120-fix-tee_shm-refcount-upstream-v1-0-5da97f584fcd@quicinc.com>
 <20241120-fix-tee_shm-refcount-upstream-v1-3-5da97f584fcd@quicinc.com>
 <CAHUa44Eoxa+NfRF-XCuV-O5uVgtC3UMT0utCLrUZ4rCBREp=pQ@mail.gmail.com>
Content-Language: en-US
From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
In-Reply-To: <CAHUa44Eoxa+NfRF-XCuV-O5uVgtC3UMT0utCLrUZ4rCBREp=pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J58ydDNocdnT0LBQScKc4bPOnl1eVNGp
X-Proofpoint-GUID: J58ydDNocdnT0LBQScKc4bPOnl1eVNGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220007


On 11/21/2024 11:08 PM, Jens Wiklander wrote:

Hi Jens,

> Hi Amirreza,
> 
> On Thu, Nov 21, 2024 at 2:37 AM Amirreza Zarrabi
> <quic_azarrabi@quicinc.com> wrote:
>>
>> The default context has a lifespan similar to the tee_device.
>> It is used as a context for shared memory if the context to which the
>> shared memory belongs is released, making the tee_shm an orphan.
>> This allows the driver implementing shm_unregister to safely make
>> subsequent calls, such as to a supplicant if needed.
>>
>> It also enables users to free the shared memory while the driver is
>> blocked on unregister_tee_device safely.
>>
>> Preferably, this should be used for all driver internal uses, using
>> teedev_get_def_context rather than calling teedev_open.
>>
>> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
>> ---
>>  drivers/tee/optee/core.c    |  2 +-
>>  drivers/tee/optee/ffa_abi.c |  2 +-
>>  drivers/tee/optee/smc_abi.c |  2 +-
>>  drivers/tee/tee_core.c      | 83 +++++++++++++++++++++++++++++----------------
>>  drivers/tee/tee_private.h   |  3 --
>>  drivers/tee/tee_shm.c       | 18 ++--------
>>  include/linux/tee_core.h    | 15 ++++++++
>>  include/linux/tee_drv.h     |  7 ----
>>  8 files changed, 73 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index c75fddc83576..78d43d0c8014 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -173,7 +173,7 @@ void optee_remove_common(struct optee *optee)
>>
>>         optee_notif_uninit(optee);
>>         optee_shm_arg_cache_uninit(optee);
>> -       teedev_close_context(optee->ctx);
>> +
>>         /*
>>          * The two devices have to be unregistered before we can free the
>>          * other resources.
>> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
>> index f3af5666bb11..6ad94f0788ad 100644
>> --- a/drivers/tee/optee/ffa_abi.c
>> +++ b/drivers/tee/optee/ffa_abi.c
>> @@ -949,7 +949,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>>         optee_shm_arg_cache_init(optee, arg_cache_flags);
>>         mutex_init(&optee->rpmb_dev_mutex);
>>         ffa_dev_set_drvdata(ffa_dev, optee);
>> -       ctx = teedev_open(optee->teedev);
>> +       ctx = teedev_get_def_context(optee->teedev);
>>         if (IS_ERR(ctx)) {
>>                 rc = PTR_ERR(ctx);
>>                 goto err_rhashtable_free;
>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>> index e9456e3e74cc..c77a3e631d04 100644
>> --- a/drivers/tee/optee/smc_abi.c
>> +++ b/drivers/tee/optee/smc_abi.c
>> @@ -1722,7 +1722,7 @@ static int optee_probe(struct platform_device *pdev)
>>         mutex_init(&optee->rpmb_dev_mutex);
>>
>>         platform_set_drvdata(pdev, optee);
>> -       ctx = teedev_open(optee->teedev);
>> +       ctx = teedev_get_def_context(optee->teedev);
>>         if (IS_ERR(ctx)) {
>>                 rc = PTR_ERR(ctx);
>>                 goto err_supp_uninit;
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 93f3b330aec8..805e1336089d 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -57,7 +57,6 @@ struct tee_context *teedev_open(struct tee_device *teedev)
>>                 goto err;
>>         }
>>
>> -       kref_init(&ctx->refcount);
>>         ctx->teedev = teedev;
>>         INIT_LIST_HEAD(&ctx->list_shm);
>>         rc = teedev->desc->ops->open(ctx);
>> @@ -73,36 +72,43 @@ struct tee_context *teedev_open(struct tee_device *teedev)
>>  }
>>  EXPORT_SYMBOL_GPL(teedev_open);
>>
>> -void teedev_ctx_get(struct tee_context *ctx)
>> +struct tee_context *teedev_get_def_context(struct tee_device *teedev)
>>  {
>> -       if (ctx->releasing)
>> -               return;
>> +       int rc;
>> +       struct tee_context *ctx = &teedev->def_ctx;
>>
>> -       kref_get(&ctx->refcount);
>> -}
>> +       ctx->teedev = teedev;
>> +       INIT_LIST_HEAD(&ctx->list_shm);
>> +       rc = teedev->desc->ops->open(ctx);
>> +       if (rc)
>> +               return ERR_PTR(rc);
> 
> I think ctx->teedev and ctx->list_shm must always be initialized or
> &teedev->def_ctx can't be used in teedev_close_context().

True, but &teedev->def_ctx is never used in teedev_close_context().
The closing of the &teedev->def_ctx simply ignored. So once opened,
&teedev->def_ctx will always remain open until the tee_device is alive. 

> We could initialize teedev->def_ctx on the first call to teedev_open()
> on that tee_device. We need a way to tell the
> teedev->desc->ops->open() to the backed driver that it's initializing
> the default context though, or optee_open() can't handle the
> tee-supplicant case properly.
> 

That's a good point. This way, it is guaranteed that there is one def_ctx
per teedev. There should be a way to tell the open() callback that it is
a def_ctx, so it is not registered as a supplicant context.


> Should we allow this function to be called more than once for each teedev?

Yes, moving to teedev_open() will fix the issue.

> Do we need serialization in this function if it's called after the
> driver is probed?
> 

True. I'll make sure there is no race.

>>
>> -static void teedev_ctx_release(struct kref *ref)
>> -{
>> -       struct tee_context *ctx = container_of(ref, struct tee_context,
>> -                                              refcount);
>> -       ctx->releasing = true;
>> -       ctx->teedev->desc->ops->release(ctx);
>> -       kfree(ctx);
>> +       return ctx;
>>  }
>> +EXPORT_SYMBOL_GPL(teedev_get_def_context);
>>
>> -void teedev_ctx_put(struct tee_context *ctx)
>> +void teedev_close_context(struct tee_context *ctx)
>>  {
>> -       if (ctx->releasing)
>> +       struct tee_device *teedev = ctx->teedev;
>> +       struct tee_shm *shm;
>> +
>> +       if (ctx == &teedev->def_ctx)
>>                 return;
>>
>> -       kref_put(&ctx->refcount, teedev_ctx_release);
>> -}
>> +       teedev->desc->ops->release(ctx);
>>
>> -void teedev_close_context(struct tee_context *ctx)
>> -{
>> -       struct tee_device *teedev = ctx->teedev;
>> +       mutex_lock(&teedev->mutex);
>> +       list_for_each_entry(shm, &ctx->list_shm, link) {
>> +               /* Context released. However, shm still holding a teedev reference.
>> +                * Replace shm->ctx with the default context so that tee_shm_get_from_id()
>> +                * fails (i.e. it is not accessible from userspace) but shm still
>> +                * holds a valid context for further clean up, e.g. shm_unregister().
>> +                */
> 
> /*
>  * Please format
>  * multiline comments
>  * like this. Please
>  * keep the lines at
>  * max 80 columns
>  * here and at other
>  * places in the patch-
>  * set.
>  */
> 

Ack.

>> +               shm->ctx = &teedev->def_ctx;
> 
> shm->ctx will always point to a valid context, even if it is the
> default context. It seems that we can always get hold of the correct
> teedev via shm->ctx->teedev. Do we need "tee: revert removal of
> redundant teedev in struct tee_shm"?
> 

It was there in case we wanted to use NULL, but with def_ctx, it is not
necessary. I am withdrawing that commit. :).

> Shouldn't the shm be removed from the ctx->list_shm and be moved to
> teedev->def_ctx.list_shm?
>

Not really. If we put shm in the teedev->def_ctx.list_shm, by the time
we are closing the def_ctx, the list is guaranteed to be empty.

However, I understand it is cleaner and more consistent to do that rather
than making changes to tee_shm_put().

I'll do it.

>> +       }
>> +       mutex_unlock(&teedev->mutex);
>>
>> -       teedev_ctx_put(ctx);
>> +       kfree(ctx);
>>         tee_device_put(teedev);
>>  }
>>  EXPORT_SYMBOL_GPL(teedev_close_context);
>> @@ -946,6 +952,8 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
>>
>>         teedev->desc = teedesc;
>>         teedev->pool = pool;
>> +       /* Only open default context when teedev_get_def_context() called. */
>> +       teedev->def_ctx.teedev = NULL;
>>
>>         return teedev;
>>  err_devt:
>> @@ -1027,16 +1035,31 @@ EXPORT_SYMBOL_GPL(tee_device_register);
>>
>>  void tee_device_put(struct tee_device *teedev)
>>  {
>> -       mutex_lock(&teedev->mutex);
>> -       /* Shouldn't put in this state */
>> -       if (!WARN_ON(!teedev->desc)) {
>> -               teedev->num_users--;
>> -               if (!teedev->num_users) {
>> -                       teedev->desc = NULL;
>> -                       complete(&teedev->c_no_users);
>> -               }
>> +       const struct tee_desc *desc;
>> +
>> +       scoped_guard(mutex, &teedev->mutex) {
>> +               desc = teedev->desc;
>> +
>> +               /* Shouldn't put in this state */
>> +               if (WARN_ON(!desc))
>> +                       return;
>> +
>> +               /* If there is still users for teedev */
>> +               if (--teedev->num_users)
> 
> Please do teedev->num_users-- first and then check. It makes the code
> easier to read.

Ack.

> 
>> +                       return;
>> +
>> +               /* tee_device_unregister() has been called and there is no
>> +                * user in userspace or kernel, including orphan shm for teedev.
>> +                * Set teedev->desc to NULL, so that teedev can not be reused.
>> +                */
>> +               teedev->desc = NULL;
>>         }
>> -       mutex_unlock(&teedev->mutex);
>> +
>> +       /* Release the default context */
>> +       desc->ops->release(&teedev->def_ctx);
> 
> This should only be done if teedev->def_ctx has been initialized.
> 

Ack.

> Cheers,
> Jens

Thank you very much for your comments :).
If you're okay with introducing def_ctx, I'll prepare a complete patchset
with all the details. 

Best Regards,
Amir


> 
>> +       teedev->def_ctx.teedev = NULL;
>> +
>> +       complete(&teedev->c_no_users);
>>  }
>>
>>  bool tee_device_get(struct tee_device *teedev)
>> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
>> index 9bc50605227c..6c7bcc308958 100644
>> --- a/drivers/tee/tee_private.h
>> +++ b/drivers/tee/tee_private.h
>> @@ -17,9 +17,6 @@ int tee_shm_get_fd(struct tee_shm *shm);
>>  bool tee_device_get(struct tee_device *teedev);
>>  void tee_device_put(struct tee_device *teedev);
>>
>> -void teedev_ctx_get(struct tee_context *ctx);
>> -void teedev_ctx_put(struct tee_context *ctx);
>> -
>>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
>>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>>                                           unsigned long addr, size_t length);
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index c0164c0f4a01..f07274291edf 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -59,8 +59,6 @@ static void tee_shm_release(struct tee_shm *shm)
>>                 release_registered_pages(shm);
>>         }
>>
>> -       teedev_ctx_put(shm->ctx);
>> -
>>         kfree(shm);
>>
>>         tee_device_put(teedev);
>> @@ -93,13 +91,6 @@ static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
>>         shm->flags = flags;
>>         shm->teedev = teedev;
>>         shm->id = id;
>> -
>> -       /*
>> -        * We're assigning this as it is needed if the shm is to be
>> -        * registered. If this function returns OK then the caller expected
>> -        * to call teedev_ctx_get() or clear shm->ctx in case it's not
>> -        * needed any longer.
>> -        */
>>         shm->ctx = ctx;
>>
>>         rc = teedev->pool->ops->alloc(teedev->pool, shm, size, align);
>> @@ -112,7 +103,6 @@ static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
>>         list_add_tail(&shm->link, &ctx->list_shm);
>>         mutex_unlock(&teedev->mutex);
>>
>> -       teedev_ctx_get(ctx);
>>         return shm;
>>  err_kfree:
>>         kfree(shm);
>> @@ -295,12 +285,10 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>>                 goto err_dev_put;
>>         }
>>
>> -       teedev_ctx_get(ctx);
>> -
>>         shm = kzalloc(sizeof(*shm), GFP_KERNEL);
>>         if (!shm) {
>>                 ret = ERR_PTR(-ENOMEM);
>> -               goto err_ctx_put;
>> +               goto err_dev_put;
>>         }
>>
>>         refcount_set(&shm->refcount, 1);
>> @@ -313,7 +301,7 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>>         num_pages = iov_iter_npages(iter, INT_MAX);
>>         if (!num_pages) {
>>                 ret = ERR_PTR(-ENOMEM);
>> -               goto err_ctx_put;
>> +               goto err_dev_put;
>>         }
>>
>>         shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
>> @@ -361,8 +349,6 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>>         kfree(shm->pages);
>>  err_free_shm:
>>         kfree(shm);
>> -err_ctx_put:
>> -       teedev_ctx_put(ctx);
>>  err_dev_put:
>>         tee_device_put(teedev);
>>         return ret;
>> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>> index a38494d6b5f4..13393ddac530 100644
>> --- a/include/linux/tee_core.h
>> +++ b/include/linux/tee_core.h
>> @@ -44,6 +44,7 @@
>>   * @idr:       register of user space shared memory objects allocated or
>>   *             registered on this device
>>   * @pool:      shared memory pool
>> + * @def_ctx:   default context used if there is no context available, e.g. internal driver calls.
>>   */
>>  struct tee_device {
>>         char name[TEE_MAX_DEV_NAME_LEN];
>> @@ -60,6 +61,7 @@ struct tee_device {
>>
>>         struct idr idr;
>>         struct tee_shm_pool *pool;
>> +       struct tee_context def_ctx;
>>  };
>>
>>  /**
>> @@ -309,6 +311,19 @@ static inline bool tee_param_is_memref(struct tee_param *param)
>>   */
>>  struct tee_context *teedev_open(struct tee_device *teedev);
>>
>> +/**
>> + * teedev_get_def_context() - Get default context for a struct tee_device
>> + * @teedev:    Device to open
>> + *
>> + * Unlike a context that returned from teedev_open(), the default context is static
>> + * and available as long as @teedev has a user ''other then this context''. This context
>> + * can be used for driver internal operation and clean up where a context should be
>> + * available, while tee_device_unregister() is waiting for other users to go away.
>> + *
>> + * @return a pointer to struct tee_context on success or an ERR_PTR on failure.
>> + */
>> +struct tee_context *teedev_get_def_context(struct tee_device *teedev);
>> +
>>  /**
>>   * teedev_close_context() - closes a struct tee_context
>>   * @ctx:       The struct tee_context to close
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index 1b57cddfecc8..9633e14ba484 100644
>> --- a/include/linux/tee_drv.h
>> +++ b/include/linux/tee_drv.h
>> @@ -7,7 +7,6 @@
>>  #define __TEE_DRV_H
>>
>>  #include <linux/device.h>
>> -#include <linux/kref.h>
>>  #include <linux/list.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/tee.h>
>> @@ -25,10 +24,6 @@ struct tee_device;
>>   * @teedev:    pointer to this drivers struct tee_device
>>   * @list_shm:  List of shared memory object owned by this context
>>   * @data:      driver specific context data, managed by the driver
>> - * @refcount:  reference counter for this structure
>> - * @releasing:  flag that indicates if context is being released right now.
>> - *             It is needed to break circular dependency on context during
>> - *              shared memory release.
>>   * @supp_nowait: flag that indicates that requests in this context should not
>>   *              wait for tee-supplicant daemon to be started if not present
>>   *              and just return with an error code. It is needed for requests
>> @@ -41,8 +36,6 @@ struct tee_context {
>>         struct tee_device *teedev;
>>         struct list_head list_shm;
>>         void *data;
>> -       struct kref refcount;
>> -       bool releasing;
>>         bool supp_nowait;
>>         bool cap_memref_null;
>>  };
>>
>> --
>> 2.34.1
>>

