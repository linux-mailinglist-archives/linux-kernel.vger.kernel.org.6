Return-Path: <linux-kernel+bounces-199280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C418D84DE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C32CFB2444A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A879012E1FF;
	Mon,  3 Jun 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2NIJJ2b"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F612C554
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424678; cv=none; b=mf8TzzFvyK93mb0fSunyx+zgSzwBCk9fFBv+fWgQQNl1hA/09HMvkDHCfPHg8lw/uDczAjK36Fcnu/l7CDUXv74qOdAxpbTAbofQ/Kba7P3zj2agNM+3tac5uPO4bra9IPM10Jnv7oElaz+E2erpDV/GHElhpSAfnhbVEhCkkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424678; c=relaxed/simple;
	bh=fGz33xrm67s/3xOHzi6aui49BF2BT8E4NGLtM0smGzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIYeEPpDpAQ4UeGUX/AgynkT6jxLb3WqDpgDom0pmJbBXHsvMANwF82sS/TE5whHeerE73ZzQObBRXdUiMQPSsNdxDi9fuy6I01TPa7O4Pvb4gZWpfRioZwOxbXxt6NkKZ1HyYjUexD5RPIFrXAC8XN24xWyHeE1oLEGuqg8y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2NIJJ2b; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b7c82e39eso4378696e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717424674; x=1718029474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HU67Frz4KLIhKgIgnFIoqv4QJpo9MobOI1TbJCtTOKA=;
        b=c2NIJJ2bK6WqFv5Qsf+bO2Hy4ysU3AeoCalAlQzXTPBf8V/hxBvFzh0ElSRO06L3ch
         nrd6xg6TXKupXMuEnvjDnuporii6fkRuNDdfhP4DxhS5B34hCcAHabRhuRGQNlBwLe+w
         UZXAhIkIJWSvj+HwAywJz1lt7JLLz9Cv7JwgnK9qUbaLgjS1e/ghn1RgxeLWDhvP5G7u
         /jnbUz7xEJKtjAttA2PJKeYewMT1VFxw6uiv434iQwCiEP0CwDKB5CP3kZYd/zHHJCB0
         VwzUHdlDA3M6GxoQ3cPjzKVF4te4inkPr4UzZoXR3yt5Q2ybGfLj3onripX3JtOnjJ20
         AoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717424674; x=1718029474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HU67Frz4KLIhKgIgnFIoqv4QJpo9MobOI1TbJCtTOKA=;
        b=PfpI4gb3wpTdLikLgeCJ+HIBzvZ1Do80wMJYD8lnLSZcZDnEWo77rCXFUq0vQqx8di
         gliyVLRbWj7AJaS+WLRToAxJOFFA8BEbz75CL4AUsp81NqdPFVNYIkUHGwfxVN8L5Gff
         xmi/TdrwBuERNgT5AEAOE1ZL4bqziRoHlmr/KLNLJHMJCdYmNprqf2IoSp68TgTwwP65
         LfzkSH9CGpQWtvX0n8781GumEIt6xmkEaA24v2Ii8aDacln2qZRGIDKLNFkc0PwYdHmn
         CFFfw5EzVoTmmMkxOCEavhuum4VpXjkYxHaSnW6sQkcSWSMbLc30EQ0Xc7KQeRrvRYJF
         mscw==
X-Forwarded-Encrypted: i=1; AJvYcCUrfyuUmw+8rXnsm2seIlZ/RSmQWidwAG243uZ+o1P0PsuuhIEuyp1KnQKn4eYNZFaKb9zVL+6PlVv26B+2S/b3TuKl+RcS2VYhGfX5
X-Gm-Message-State: AOJu0YyD+S8hjYASlGl6FEQESOAepX6YKeKrOPd02lphBatY/ZBk8xwt
	EARhn/sy3cGA9my7olPZ2LdVu/TjHNnlerQOhJgVvO7uHZAItyXnF2Ot4ccj841LSX/kmirAzCu
	+VK5TkWySDGGeUNfGHMrDa2qWTN3JJ3JplPNWEQ==
X-Google-Smtp-Source: AGHT+IFSkxpmdDquL3WnBhvl8mkF9cp/jBUTPsK7w7Fy+lvXPrOrD8Bxo9GvPPtUOX2jGfVSOpcaXCUHE8mly6n5yrM=
X-Received: by 2002:a19:8c1e:0:b0:522:34a9:a7e7 with SMTP id
 2adb3069b0e04-52b89576a71mr6693705e87.22.1717424673764; Mon, 03 Jun 2024
 07:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521081001.2989417-1-arnaud.pouliquen@foss.st.com>
 <20240521081001.2989417-6-arnaud.pouliquen@foss.st.com> <ZlZM/hgSO4EeRVqS@p14s>
 <d9e1356a-d8bf-40a3-9a78-424ead8089a9@foss.st.com> <ZleReEIgD8O5zATO@p14s>
 <5b3f8346-d6db-4da3-9613-20cf9f3c226b@foss.st.com> <ZloIwfFwkpKYLU9k@p14s> <047e31c6-1b6d-4792-a913-4197e2e53b32@foss.st.com>
In-Reply-To: <047e31c6-1b6d-4792-a913-4197e2e53b32@foss.st.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 3 Jun 2024 08:24:22 -0600
Message-ID: <CANLsYkx4MeUwoFF9aUutdQxOaLbbJ7q0cWw+EMVDXoprnm8QLA@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] remoteproc: core: support of the tee interface
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 02:22, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hello Mathieu,
>
> On 5/31/24 19:28, Mathieu Poirier wrote:
> > On Thu, May 30, 2024 at 09:42:26AM +0200, Arnaud POULIQUEN wrote:
> >> Hello Mathieu,
> >>
> >> On 5/29/24 22:35, Mathieu Poirier wrote:
> >>> On Wed, May 29, 2024 at 09:13:26AM +0200, Arnaud POULIQUEN wrote:
> >>>> Hello Mathieu,
> >>>>
> >>>> On 5/28/24 23:30, Mathieu Poirier wrote:
> >>>>> On Tue, May 21, 2024 at 10:09:59AM +0200, Arnaud Pouliquen wrote:
> >>>>>> 1) on start:
> >>>>>> - Using the TEE loader, the resource table is loaded by an external entity.
> >>>>>> In such case the resource table address is not find from the firmware but
> >>>>>> provided by the TEE remoteproc framework.
> >>>>>> Use the rproc_get_loaded_rsc_table instead of rproc_find_loaded_rsc_table
> >>>>>> - test that rproc->cached_table is not null before performing the memcpy
> >>>>>>
> >>>>>> 2)on stop
> >>>>>> The use of the cached_table seems mandatory:
> >>>>>> - during recovery sequence to have a snapshot of the resource table
> >>>>>>   resources used,
> >>>>>> - on stop to allow  for the deinitialization of resources after the
> >>>>>>   the remote processor has been shutdown.
> >>>>>> However if the TEE interface is being used, we first need to unmap the
> >>>>>> table_ptr before setting it to rproc->cached_table.
> >>>>>> The update of rproc->table_ptr to rproc->cached_table is performed in
> >>>>>> tee_remoteproc.
> >>>>>>
> >>>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >>>>>> ---
> >>>>>>  drivers/remoteproc/remoteproc_core.c | 31 +++++++++++++++++++++-------
> >>>>>>  1 file changed, 23 insertions(+), 8 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> >>>>>> index 42bca01f3bde..3a642151c983 100644
> >>>>>> --- a/drivers/remoteproc/remoteproc_core.c
> >>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
> >>>>>> @@ -1267,6 +1267,7 @@ EXPORT_SYMBOL(rproc_resource_cleanup);
> >>>>>>  static int rproc_set_rsc_table_on_start(struct rproc *rproc, const struct firmware *fw)
> >>>>>>  {
> >>>>>>          struct resource_table *loaded_table;
> >>>>>> +        struct device *dev = &rproc->dev;
> >>>>>>
> >>>>>>          /*
> >>>>>>           * The starting device has been given the rproc->cached_table as the
> >>>>>> @@ -1276,12 +1277,21 @@ static int rproc_set_rsc_table_on_start(struct rproc *rproc, const struct firmwa
> >>>>>>           * this information to device memory. We also update the table_ptr so
> >>>>>>           * that any subsequent changes will be applied to the loaded version.
> >>>>>>           */
> >>>>>> -        loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
> >>>>>> -        if (loaded_table) {
> >>>>>> -                memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
> >>>>>> -                rproc->table_ptr = loaded_table;
> >>>>>> +        if (rproc->tee_interface) {
> >>>>>> +                loaded_table = rproc_get_loaded_rsc_table(rproc, &rproc->table_sz);
> >>>>>> +                if (IS_ERR(loaded_table)) {
> >>>>>> +                        dev_err(dev, "can't get resource table\n");
> >>>>>> +                        return PTR_ERR(loaded_table);
> >>>>>> +                }
> >>>>>> +        } else {
> >>>>>> +                loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
> >>>>>>          }
> >>>>>>
> >>>>>> +        if (loaded_table && rproc->cached_table)
> >>>>>> +                memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
> >>>>>> +
> >>>>>
> >>>>> Why is this not part of the else {} above as it was the case before this patch?
> >>>>> And why was an extra check for ->cached_table added?
> >>>>
> >>>> Here we have to cover 2 use cases if rproc->tee_interface is set.
> >>>> 1) The remote processor is in stop state
> >>>>      - loaded_table points to the resource table in the remote memory and
> >>>>      -  rproc->cached_table is null
> >>>>      => no memcopy
> >>>> 2) crash recovery
> >>>>      - loaded_table points to the resource table in the remote memory
> >>>>      - rproc-cached_table point to a copy of the resource table
> >>>
> >>> A cached_table exists because it was created in rproc_reset_rsc_table_on_stop().
> >>> But as the comment says [1], that part of the code was meant to be used for the
> >>> attach()/detach() use case.  Mixing both will become extremely confusing and
> >>> impossible to maintain.
> >>
> >> i am not sure to understand your point here... the cached_table table was
> >> already existing for the "normal" case[2]. Seems to me that the cache table is
> >> needed on stop in all scenarios.
> >>
> >> [2]
> >> https://elixir.bootlin.com/linux/v4.20.17/source/drivers/remoteproc/remoteproc_core.c#L1402
> >>
> >>>
> >>> I think the TEE scenario should be as similar as the "normal" one where TEE is
> >>> not involved.  To that end, I suggest to create a cached_table in
> >>> tee_rproc_parse_fw(), exactly the same way it is done in
> >>> rproc_elf_load_rsc_table().  That way the code path in
> >>> rproc_set_rsc_table_on_start() become very similar and we have a cached_table to
> >>> work with when the remote processor is recovered.  In fact we may not need
> >>> rproc_set_rsc_table_on_start() at all but that needs to be asserted.
> >>
> >> This is was I proposed in my V4 [3]. Could you please confirm that this aligns
> >> with what you have in mind?
> >
> > After spending more time on this I have the following 3 observations:
> >
> > 1) We need a ->cached_table, otherwise the crash recovery path gets really
> > messy.
> >
> > 2) It _might_ be a good idea to rename tee_rproc_get_loaded_rsc_table() to
> > tee_rproc_find_loaded_rsc_table() to be aligned with the scenario where the
> > firmware is loaded by the remoteproc core.  I think you had
> > tee_rproc_find_loaded_rsc_table() in the first place and I asked you to change
> > it.  If so, apologies - reviewing patches isn't an exact science.
> >
> > 3) The same way ->cached_table is created in rproc_elf_load_rsc_table(), which
> > is essentially ops::parse_fw(), we should create one in tee_rproc_parse_fw()
> > with a kmemdup().  Exactly the same as in rproc_elf_load_rsc_table().  In
> > tee_rproc_parse_fw(), @rsc_table should be iounmap'ed right away so that we
> > don't need to keep a local variable to free it later.  In rproc_start() the call
> > to rproc_find_loaded_rsc_table() will get another mapped handle to the resource
> > table in memory.  It might be a little unefficient but it sure beats doing a lot
> > of modifications in the core.
>
> Remapping the resource table in rproc_find_loaded_rsc_table will require that we
> unmap it on rproc_stop before updating rproc->table_ptr to rproc->cached_table.
>

Exactly.

> On the other hand, I wonder if declaring the memory region in the stm32-rproc DT
> node would address this second mapping and avoid a map in
> rproc_find_loaded_rsc_table().
>

That would be even better.

> I will do the V6 integrating your suggestions and having a deeper look on the
> resource table map/unmap.
>
> >
> > As I said above this isn't an exact science and we may need to changes more
> > things but at least it should take us a little further.
>
> That seems to me reasonable and part of the normal upstream process :)
>
>
> Thanks,
> Arnaud
>
> >
> > Thanks,
> > Mathieu
> >
> >> In such a case, should I keep the updates below in
> >> rproc_reset_rsc_table_on_stop(), or should I revert to using rproc->rsc_table to
> >> store the pointer to the resource table in tee_remoteproc for the associated
> >> memory map/unmap?"
> >>
> >> [3]
> >> https://patchwork.kernel.org/project/linux-remoteproc/patch/20240308144708.62362-2-arnaud.pouliquen@foss.st.com/
> >>
> >> Thanks,
> >> Arnaud
> >>
> >>>
> >>> [1]. https://elixir.bootlin.com/linux/v6.10-rc1/source/drivers/remoteproc/remoteproc_core.c#L1565
> >>>
> >>>>      => need to perform the memcpy to reapply settings in the resource table
> >>>>
> >>>> I can duplicate the memcpy in if{} and else{} but this will be similar code
> >>>> as needed in both case.
> >>>> Adding rproc->cached_table test if proc->tee_interface=NULL seems also
> >>>> reasonable as a memcpy from 0 should not be performed.
> >>>>
> >>>>
> >>>>>
> >>>>> This should be a simple change, i.e introduce an if {} else {} block to take
> >>>>> care of the two scenarios.  Plus the comment is misplaced now.
> >>>>
> >>>> What about split it in 2 patches?
> >>>> - one adding the test on rproc->cached_table for the memcpy
> >>>> - one adding the if {} else {}?
> >>>>
> >>>> Thanks,
> >>>> Arnaud
> >>>>
> >>>>
> >>>>>
> >>>>> More comments tomorrow.
> >>>>>
> >>>>> Thanks,
> >>>>> Mathieu
> >>>>>
> >>>>>> +        rproc->table_ptr = loaded_table;
> >>>>>> +
> >>>>>>          return 0;
> >>>>>>  }
> >>>>>>
> >>>>>> @@ -1318,11 +1328,16 @@ static int rproc_reset_rsc_table_on_stop(struct rproc *rproc)
> >>>>>>          kfree(rproc->clean_table);
> >>>>>>
> >>>>>>  out:
> >>>>>> -        /*
> >>>>>> -         * Use a copy of the resource table for the remainder of the
> >>>>>> -         * shutdown process.
> >>>>>> +        /* If the remoteproc_tee interface is used, then we have first to unmap the resource table
> >>>>>> +         * before updating the proc->table_ptr reference.
> >>>>>>           */
> >>>>>> -        rproc->table_ptr = rproc->cached_table;
> >>>>>> +        if (!rproc->tee_interface) {
> >>>>>> +                /*
> >>>>>> +                 * Use a copy of the resource table for the remainder of the
> >>>>>> +                 * shutdown process.
> >>>>>> +                 */
> >>>>>> +                rproc->table_ptr = rproc->cached_table;
> >>>>>> +        }
> >>>>>>          return 0;
> >>>>>>  }
> >>>>>>
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>>

