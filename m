Return-Path: <linux-kernel+bounces-421618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7465F9D8DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619F9B2587C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EEB1C4A07;
	Mon, 25 Nov 2024 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cEbqmN/s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C71552FC;
	Mon, 25 Nov 2024 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732568137; cv=none; b=eiRgkx6HL2czoe9C4ir1ysYx2uXKhdV5FVxFjLr8G2/qH2DyMvNEqhwJ/bARuS0p36FhLYi5Wm52EcW+x0ppjsP37zjckSLVKww2byVCJ0GEK+t/T8hNOFWA2GL4z85WGqu3egBbx55yqSJJ7yeLWqvTog6htn3ga1bjbNejbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732568137; c=relaxed/simple;
	bh=zIxyXql/GcL+hp23mu8Ai3Qeoz+XpRtZ5RhtbhRrl4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tqu/gGXgfI1g7RLQKE2WD+e6CRp63mteyG14rYZr8SHnoihTK6zOC5iLkK5Tl9HySGx4VBsZNFxFRMN2cwYETuaWENEdkItx1R6JTaFWWPx8d1tAT1r1J4gzwugAlA3ngVbn3y5/R793lfhevycW8qA2q7diXXMCKMXWKciTL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cEbqmN/s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APDC052011747;
	Mon, 25 Nov 2024 20:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hd61OeXMHhDZbBgVnM8C+hNN4YY5ngjaE/zTpiMCyrM=; b=cEbqmN/sjQYWKPRB
	m3lCZbCtTxwaeyhSJpKjjbUGV8wboULcgMFOWSLBivVWy7oLDDdoNqo2RVqyUXKz
	NhWTtdxXK6rGYNN0bNXVEstpXkQ5tFrl1kpjye6oQNviqy4/FgKaWrmQIFOfS9j/
	EvPrs4sTto0aOh2wOSbqnR0UcnAJoMnLMIgmyOfXzI2QIT8GuvaZ+9kF0nb9IkEE
	AtXk/iZKRWSePhPOb6rv/KlfvbVrqMP/6ZDRvkmm20muROuol/M5cj2/ZyQpxitn
	21c2WkdC+nqjorZrNPcOQAtp87xmxC5TgA0kzYMwQLAnbiezJLcNA6NJPASJkVv/
	4gk8FA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434sw9948j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 20:55:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4APKtT1H001360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 20:55:29 GMT
Received: from [10.4.85.58] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 25 Nov
 2024 12:55:28 -0800
Message-ID: <1a9269cb-204a-472d-b495-ac44f36cf131@quicinc.com>
Date: Tue, 26 Nov 2024 07:55:25 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] tee: introduce orphan tee_shm and default context
To: Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander
	<jens.wiklander@linaro.org>
CC: <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20241120-fix-tee_shm-refcount-upstream-v1-0-5da97f584fcd@quicinc.com>
 <20241120-fix-tee_shm-refcount-upstream-v1-3-5da97f584fcd@quicinc.com>
 <CAHUa44Eoxa+NfRF-XCuV-O5uVgtC3UMT0utCLrUZ4rCBREp=pQ@mail.gmail.com>
 <3ab115bf-7ac6-452f-b760-0d631b6e75dd@quicinc.com>
 <CAFA6WYNBsZ5V6N676yfDgTL4jMeXtEB0xGm5zSq3BFeeCpz9Nw@mail.gmail.com>
 <a4e474c2-80b7-45db-b1a0-37950168edf0@quicinc.com>
 <CAFA6WYOvMnvdhLvgOzLMyugRLPc62pHdJEGAhhwDJHRrVxCs1Q@mail.gmail.com>
 <CAHUa44HZbODOx7N4+WiNjQwrjwo7T=bQfZ5N-EjoMmXnfC4-Lg@mail.gmail.com>
 <CAFA6WYNbvxs-KRBkBxdD7M0Z=qLkT0ODDo-4_H5ZbZxqK4va7g@mail.gmail.com>
Content-Language: en-US
From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
In-Reply-To: <CAFA6WYNbvxs-KRBkBxdD7M0Z=qLkT0ODDo-4_H5ZbZxqK4va7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z5_mQvagMdzLs0zYsItNa3d_NBmh04Js
X-Proofpoint-ORIG-GUID: Z5_mQvagMdzLs0zYsItNa3d_NBmh04Js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250174



On 11/25/2024 6:51 PM, Sumit Garg wrote:
> On Mon, 25 Nov 2024 at 12:53, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>>
>> On Mon, Nov 25, 2024 at 7:14 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>
>>> On Mon, 25 Nov 2024 at 03:00, Amirreza Zarrabi
>>> <quic_azarrabi@quicinc.com> wrote:
>>>>
>>>>
>>>> Hi Sumit,
>>>>
>>>> Thank you so much for the comemnts :).
>>>>
>>>> On 11/23/2024 9:32 PM, Sumit Garg wrote:
>>>>> Hi Amirreza,
>>>>>
>>>>> Thanks for proposing this.
>>>>>
>>>>> On Fri, 22 Nov 2024 at 06:38, Amirreza Zarrabi
>>>>> <quic_azarrabi@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 11/21/2024 11:08 PM, Jens Wiklander wrote:
>>>>>>
>>>>>> Hi Jens,
>>>>>>
>>>>>>> Hi Amirreza,
>>>>>>>
>>>>>>> On Thu, Nov 21, 2024 at 2:37 AM Amirreza Zarrabi
>>>>>>> <quic_azarrabi@quicinc.com> wrote:
>>>>>>>>
>>>>>>>> The default context has a lifespan similar to the tee_device.
>>>>>
>>>>> Since it's associated with tee_device context, let's call it obvious
>>>>> via renaming it as device context instead (s/def_ctx/dev_ctx/ in this
>>>>> patch).
>>>>>
>>>>
>>>> Make sense, I'll rename it.
>>>>
>>>>>>>> It is used as a context for shared memory if the context to which the
>>>>>>>> shared memory belongs is released, making the tee_shm an orphan.
>>>>>>>> This allows the driver implementing shm_unregister to safely make
>>>>>>>> subsequent calls, such as to a supplicant if needed.
>>>>>>>>
>>>>>>>> It also enables users to free the shared memory while the driver is
>>>>>>>> blocked on unregister_tee_device safely.
>>>>>>>>
>>>>>>>> Preferably, this should be used for all driver internal uses, using
>>>>>>>> teedev_get_def_context rather than calling teedev_open.
>>>>>
>>>>> Makes sense to me.
>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
>>>>>>>> ---
>>>>>>>>  drivers/tee/optee/core.c    |  2 +-
>>>>>>>>  drivers/tee/optee/ffa_abi.c |  2 +-
>>>>>>>>  drivers/tee/optee/smc_abi.c |  2 +-
>>>>>>>>  drivers/tee/tee_core.c      | 83 +++++++++++++++++++++++++++++----------------
>>>>>>>>  drivers/tee/tee_private.h   |  3 --
>>>>>>>>  drivers/tee/tee_shm.c       | 18 ++--------
>>>>>>>>  include/linux/tee_core.h    | 15 ++++++++
>>>>>>>>  include/linux/tee_drv.h     |  7 ----
>>>>>>>>  8 files changed, 73 insertions(+), 59 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>>>>>>>> index c75fddc83576..78d43d0c8014 100644
>>>>>>>> --- a/drivers/tee/optee/core.c
>>>>>>>> +++ b/drivers/tee/optee/core.c
>>>>>>>> @@ -173,7 +173,7 @@ void optee_remove_common(struct optee *optee)
>>>>>>>>
>>>>>>>>         optee_notif_uninit(optee);
>>>>>>>>         optee_shm_arg_cache_uninit(optee);
>>>>>>>> -       teedev_close_context(optee->ctx);
>>>>>>>> +
>>>>>>>>         /*
>>>>>>>>          * The two devices have to be unregistered before we can free the
>>>>>>>>          * other resources.
>>>>>>>> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
>>>>>>>> index f3af5666bb11..6ad94f0788ad 100644
>>>>>>>> --- a/drivers/tee/optee/ffa_abi.c
>>>>>>>> +++ b/drivers/tee/optee/ffa_abi.c
>>>>>>>> @@ -949,7 +949,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>>>>>>>>         optee_shm_arg_cache_init(optee, arg_cache_flags);
>>>>>>>>         mutex_init(&optee->rpmb_dev_mutex);
>>>>>>>>         ffa_dev_set_drvdata(ffa_dev, optee);
>>>>>>>> -       ctx = teedev_open(optee->teedev);
>>>>>>>> +       ctx = teedev_get_def_context(optee->teedev);
>>>>>>>>         if (IS_ERR(ctx)) {
>>>>>>>>                 rc = PTR_ERR(ctx);
>>>>>>>>                 goto err_rhashtable_free;
>>>>>>>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>>>>>>>> index e9456e3e74cc..c77a3e631d04 100644
>>>>>>>> --- a/drivers/tee/optee/smc_abi.c
>>>>>>>> +++ b/drivers/tee/optee/smc_abi.c
>>>>>>>> @@ -1722,7 +1722,7 @@ static int optee_probe(struct platform_device *pdev)
>>>>>>>>         mutex_init(&optee->rpmb_dev_mutex);
>>>>>>>>
>>>>>>>>         platform_set_drvdata(pdev, optee);
>>>>>>>> -       ctx = teedev_open(optee->teedev);
>>>>>>>> +       ctx = teedev_get_def_context(optee->teedev);
>>>>>>>>         if (IS_ERR(ctx)) {
>>>>>>>>                 rc = PTR_ERR(ctx);
>>>>>>>>                 goto err_supp_uninit;
>>>>>>>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>>>>>>>> index 93f3b330aec8..805e1336089d 100644
>>>>>>>> --- a/drivers/tee/tee_core.c
>>>>>>>> +++ b/drivers/tee/tee_core.c
>>>>>>>> @@ -57,7 +57,6 @@ struct tee_context *teedev_open(struct tee_device *teedev)
>>>>>>>>                 goto err;
>>>>>>>>         }
>>>>>>>>
>>>>>>>> -       kref_init(&ctx->refcount);
>>>>>>>>         ctx->teedev = teedev;
>>>>>>>>         INIT_LIST_HEAD(&ctx->list_shm);
>>>>>>>>         rc = teedev->desc->ops->open(ctx);
>>>>>>>> @@ -73,36 +72,43 @@ struct tee_context *teedev_open(struct tee_device *teedev)
>>>>>>>>  }
>>>>>>>>  EXPORT_SYMBOL_GPL(teedev_open);
>>>>>>>>
>>>>>>>> -void teedev_ctx_get(struct tee_context *ctx)
>>>>>>>> +struct tee_context *teedev_get_def_context(struct tee_device *teedev)
>>>>>>>>  {
>>>>>>>> -       if (ctx->releasing)
>>>>>>>> -               return;
>>>>>>>> +       int rc;
>>>>>>>> +       struct tee_context *ctx = &teedev->def_ctx;
>>>>>>>>
>>>>>>>> -       kref_get(&ctx->refcount);
>>>>>>>> -}
>>>>>>>> +       ctx->teedev = teedev;
>>>>>>>> +       INIT_LIST_HEAD(&ctx->list_shm);
>>>>>>>> +       rc = teedev->desc->ops->open(ctx);
>>>>>>>> +       if (rc)
>>>>>>>> +               return ERR_PTR(rc);
>>>>>>>
>>>>>>> I think ctx->teedev and ctx->list_shm must always be initialized or
>>>>>>> &teedev->def_ctx can't be used in teedev_close_context().
>>>>>>
>>>>>> True, but &teedev->def_ctx is never used in teedev_close_context().
>>>>>> The closing of the &teedev->def_ctx simply ignored. So once opened,
>>>>>> &teedev->def_ctx will always remain open until the tee_device is alive.
>>>>>>
>>>>>>> We could initialize teedev->def_ctx on the first call to teedev_open()
>>>>>>> on that tee_device. We need a way to tell the
>>>>>>> teedev->desc->ops->open() to the backed driver that it's initializing
>>>>>>> the default context though, or optee_open() can't handle the
>>>>>>> tee-supplicant case properly.
>>>>>>>
>>>>>>
>>>>>> That's a good point. This way, it is guaranteed that there is one def_ctx
>>>>>> per teedev. There should be a way to tell the open() callback that it is
>>>>>> a def_ctx, so it is not registered as a supplicant context.
>>>>>>
>>>>>>
>>>>>>> Should we allow this function to be called more than once for each teedev?
>>>>>>
>>>>>> Yes, moving to teedev_open() will fix the issue.
>>>>>>
>>>>>>> Do we need serialization in this function if it's called after the
>>>>>>> driver is probed?
>>>>>>>
>>>>>>
>>>>>> True. I'll make sure there is no race.
>>>>>>
>>>>>>>>
>>>>>>>> -static void teedev_ctx_release(struct kref *ref)
>>>>>>>> -{
>>>>>>>> -       struct tee_context *ctx = container_of(ref, struct tee_context,
>>>>>>>> -                                              refcount);
>>>>>>>> -       ctx->releasing = true;
>>>>>>>> -       ctx->teedev->desc->ops->release(ctx);
>>>>>>>> -       kfree(ctx);
>>>>>>>> +       return ctx;
>>>>>>>>  }
>>>>>>>> +EXPORT_SYMBOL_GPL(teedev_get_def_context);
>>>>>>>>
>>>>>>>> -void teedev_ctx_put(struct tee_context *ctx)
>>>>>>>> +void teedev_close_context(struct tee_context *ctx)
>>>>>>>>  {
>>>>>>>> -       if (ctx->releasing)
>>>>>>>> +       struct tee_device *teedev = ctx->teedev;
>>>>>>>> +       struct tee_shm *shm;
>>>>>>>> +
>>>>>>>> +       if (ctx == &teedev->def_ctx)
>>>>>>>>                 return;
>>>>>>>>
>>>>>>>> -       kref_put(&ctx->refcount, teedev_ctx_release);
>>>>>>>> -}
>>>>>>>> +       teedev->desc->ops->release(ctx);
>>>>>>>>
>>>>>>>> -void teedev_close_context(struct tee_context *ctx)
>>>>>>>> -{
>>>>>>>> -       struct tee_device *teedev = ctx->teedev;
>>>>>>>> +       mutex_lock(&teedev->mutex);
>>>>>>>> +       list_for_each_entry(shm, &ctx->list_shm, link) {
>>>>>>>> +               /* Context released. However, shm still holding a teedev reference.
>>>>>>>> +                * Replace shm->ctx with the default context so that tee_shm_get_from_id()
>>>>>>>> +                * fails (i.e. it is not accessible from userspace) but shm still
>>>>>>>> +                * holds a valid context for further clean up, e.g. shm_unregister().
>>>>>>>> +                */
>>>>>>>
>>>>>>> /*
>>>>>>>  * Please format
>>>>>>>  * multiline comments
>>>>>>>  * like this. Please
>>>>>>>  * keep the lines at
>>>>>>>  * max 80 columns
>>>>>>>  * here and at other
>>>>>>>  * places in the patch-
>>>>>>>  * set.
>>>>>>>  */
>>>>>>>
>>>>>>
>>>>>> Ack.
>>>>>>
>>>>>>>> +               shm->ctx = &teedev->def_ctx;
>>>>>>>
>>>>>>> shm->ctx will always point to a valid context, even if it is the
>>>>>>> default context. It seems that we can always get hold of the correct
>>>>>>> teedev via shm->ctx->teedev. Do we need "tee: revert removal of
>>>>>>> redundant teedev in struct tee_shm"?
>>>>>>>
>>>>>>
>>>>>> It was there in case we wanted to use NULL, but with def_ctx, it is not
>>>>>> necessary. I am withdrawing that commit. :).
>>>>>>
>>>>>>> Shouldn't the shm be removed from the ctx->list_shm and be moved to
>>>>>>> teedev->def_ctx.list_shm?
>>>>>
>>>>> +1
>>>>>
>>>>
>>>> Ack.
>>>>
>>>>>>>
>>>>>>
>>>>>> Not really. If we put shm in the teedev->def_ctx.list_shm, by the time
>>>>>> we are closing the def_ctx, the list is guaranteed to be empty.
>>>>>>
>>>>>> However, I understand it is cleaner and more consistent to do that rather
>>>>>> than making changes to tee_shm_put().
>>>>>>
>>>>>> I'll do it.
>>>>>>
>>>>>>>> +       }
>>>>>>>> +       mutex_unlock(&teedev->mutex);
>>>>>>>>
>>>>>>>> -       teedev_ctx_put(ctx);
>>>>>>>> +       kfree(ctx);
>>>>>>>>         tee_device_put(teedev);
>>>>>>>>  }
>>>>>>>>  EXPORT_SYMBOL_GPL(teedev_close_context);
>>>>>>>> @@ -946,6 +952,8 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
>>>>>>>>
>>>>>>>>         teedev->desc = teedesc;
>>>>>>>>         teedev->pool = pool;
>>>>>>>> +       /* Only open default context when teedev_get_def_context() called. */
>>>>>>>> +       teedev->def_ctx.teedev = NULL;
>>>>>
>>>>> Why don't you open the device context here only? This will associate
>>>>> it automatically with teedev lifespan and then
>>>>> teedev_get_def_context() will just return a reference to that.
>>>>>
>>>>> -Sumit
>>>>>
>>>>
>>>> So my assumption is that the tee_devic_alloc() is called as part of
>>>> the driver initialization; there is no guarantee that at this time the
>>>> driver is actually ready to accept any open() callback.
>>>>
>>>
>>> The drivers should be able to handle open() callback since we already
>>> check for !teedesc->ops->open in the beginning of tee_devic_alloc().
>>> Also, we need to open a device context for !TEE_DESC_PRIVILEGED such
>>> that we don't open a supplicant device context there.
>>
>> It would be nice to have the device context fully initialized when the
>> probe function returns. How about adding a "bool is_dev_ctx" to struct
>> tee_context so the open() callback can tell that this is a special
>> tee_contex?
> 
> Sure, that will be useful to distinguish the device context from
> normal client context.
> 
> -Sumit
> 

So, as far as the open() callback, I do not believe checking if it is not null
is reasonable for calling it here. Most drivers allocate resources and then
initialize them. So, assume these steps for a TEE driver:
 (1) allocate internal data structures, 
 (2) allocate the device,
 (3) initialize the internal data structurse and then
 (4) register the device.

Having these steps for a backend driver means that if you call open() at
step (2), the internal data structures are not ready.

I was originally thinking of going with Jens' suggestion to open dev_ctx in
the teedev_open(), and use a flag to distinguish the type of context for
the open() callback

What about this:
Open the dev_ctx in the tee_device_register(), at the last step before
setting the TEE_DEVICE_FLAG_REGISTERED flag. Then the open() callback can
check for this flag to determine if it is a normal context or dev_ctx.
If the open() is called while the device has not been registered, it should
handle it differently

- Amir

>>
>> Cheers,
>> Jens
>>
>>>
>>> -Sumit

