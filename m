Return-Path: <linux-kernel+bounces-566199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66698A674CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE525171EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A71E5209;
	Tue, 18 Mar 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m6vZrlgW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493220C015
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303904; cv=none; b=bxowmx6JA2WBOs7gfWEa/XLqHLJSiN232bJd9UkYF8X8p+ofPjfaYij00GTp+UFlFLalXouODBChjHtj8QVFV5zFl7oOpD1TJ1T4jUMVg9WV+ZHAIFhJmqEzQhTPIdZx0BTQZTotQgKjsZVH5S1HS4Em1WMGEZ+4T5Vk/cNWPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303904; c=relaxed/simple;
	bh=pSS9b4KjyeRX3m+Vcu1trQJvwn2ZHZfbAHkYS+dr/is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3ueTQvQFKbCBXq/4/Q/N40CO9PWLFY6ukkoELpswTpfpCpy7tTxTM9uCSCHk8YoS3dCR0focJMeqzrcxZ5Fjl0NWR5L9rad4kKxnhlRz50F2AXB+CUj3FfH30N0MNFZ0kJavY8GHvogi6EdMmS0VlYnoaUP1fTfUsnNew9eb3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m6vZrlgW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225d66a4839so68987615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742303897; x=1742908697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PvgZOP/grQ6MrsvtBZqJIB/hr36wNKPADFDTJgs3uI=;
        b=m6vZrlgWoFrMu3x5pa4XIRk4GS8Q33fYmTqqKdoRCpEWsecHpydCDqcfGohchS4/ge
         rApLBHVpq3JXu/rtmSHQVUeDxelCN1ATsWeP1hl4Y96qURbzofJIgzrOS4J5htVTOmZe
         sHnv0gpNA57jINZ/6MOIbG8DW7+oXQLx9exFyDzsvVmFXcYWXI6+f6v0TdV8+jlDNY5x
         NU5DbUYItA5Sfo1FNb8yABcSFPV01nMsmLHTwLLlKLyDfkbPt0qvEUDNawn0bgyVqm9j
         8qBD8cn4WNHqa3Dwtq3bnXlGKsb2La8E3uVQpnqgYwtm/iDh1gBoO2Tn9hCETjZTdprl
         TieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303897; x=1742908697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PvgZOP/grQ6MrsvtBZqJIB/hr36wNKPADFDTJgs3uI=;
        b=pkNXLpnx6mWz+zQEaXUlScW3Aei4BsVKDRbryl6o1oJqkR56hdEna9VAxnZg4uCMDu
         BxFAvoiLqqnOVavLWIuXdVrJVw+YYPDoCkTAsBTy/Lcfa0bY/OloRcDgkH2Ss0X2GHdM
         UBHWapeh6AZV7CFnaNF6HQLvXqAlMjEpbH1DK88t48l8C3mqpUh8wlbvsEI2yU3kiTFn
         iV3nceeLYn8R9KmROeVbF4421OohCOeHRl4NzkhgelY92x8gakTHtu8CoArl/juZKhNb
         rVplETR+Nhl3LbuLEEpvN1obvYbdwqy5D5YrdTm0xvpQPGWEtibcFb9RM+acqugioKj0
         dMzA==
X-Forwarded-Encrypted: i=1; AJvYcCWcGaPYyMCN5ePEuy/Vi4mFrQPRjGain9oWrWTCj+Kt3K7AFCcmQyyK8rlarDjsWRGlCjKK+Gdx6ilaBbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rTujfFW2LQVPcjAbFs5X/ovVaQCG8/yHT11GYXVdjWts/L2q
	XvtvBCP3wr3AnIyoaKmkatqhaNi5EUgdFmq2kCDCWgdP0+wQBoGGsXfMT4Hr7ms=
X-Gm-Gg: ASbGncuZTRAelK6wFIZ2BzO95zn1urkhpXQv7sMxzoNs0sXxMn2duJKkuXqYwPryg2A
	SW2V1W6HWYL4mjCumiY9ZND1xJohpanc7mZhsgMlKGxG57XHnacbGHfkjXL9Hwu9OMtF0U4WI57
	xc+koAPMLnNaOPpctuqUEhdwOmkRQhyNRXqYwaovsK0BS3nGy0M/f/MLA8V59naXtUgtPiNYqWv
	MNx4Rjs6FVIiT+tZ2xmkjomIhgzWY/twNtEjuRck8PWZUQiAwFrUYVB6Yl2JtBdnSCvyvHjwhk5
	nqkvtVnbKCOCKRoeOVsst7b0bwLSb60MtIeu4jInaSlmmNRP9847
X-Google-Smtp-Source: AGHT+IE6Kvikqae/QIhUUltUVzZbzSr6m/bq+X2/1Wo+d+2XzyqBFo8+FN+U7vDveLY2PY01G/wguw==
X-Received: by 2002:a05:6a21:3288:b0:1f3:323e:3743 with SMTP id adf61e73a8af0-1fa5002d58cmr4560532637.12.1742303897279;
        Tue, 18 Mar 2025 06:18:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea05961sm8895763a12.46.2025.03.18.06.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 06:18:16 -0700 (PDT)
Message-ID: <43dcef61-c574-46a9-9a94-06316d086181@kernel.dk>
Date: Tue, 18 Mar 2025 07:18:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
To: Sidong Yang <sidong.yang@furiosa.ai>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <20250317135742.4331-5-sidong.yang@furiosa.ai>
 <3a883e1e-d822-4c89-a7b0-f8802b8cc261@kernel.dk>
 <Z9jTYWAvcWJNyaIN@sidongui-MacBookPro.local>
 <566c700c-d3d5-4899-8de1-87092e76310c@gmail.com>
 <Z9km_8ai2zq86JKI@sidongui-MacBookPro.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9km_8ai2zq86JKI@sidongui-MacBookPro.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 1:55 AM, Sidong Yang wrote:
> On Tue, Mar 18, 2025 at 07:25:51AM +0000, Pavel Begunkov wrote:
>> On 3/18/25 01:58, Sidong Yang wrote:
>>> On Mon, Mar 17, 2025 at 09:40:05AM -0600, Jens Axboe wrote:
>>>> On 3/17/25 7:57 AM, Sidong Yang wrote:
>>>>> This patch introduces btrfs_uring_import_iovec(). In encoded read/write
>>>>> with uring cmd, it uses import_iovec without supporting fixed buffer.
>>>>> btrfs_using_import_iovec() could use fixed buffer if cmd flags has
>>>>> IORING_URING_CMD_FIXED.
>>>>>
>>>>> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
>>>>> ---
>>>>>   fs/btrfs/ioctl.c | 32 ++++++++++++++++++++++++--------
>>>>>   1 file changed, 24 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index 6c18bad53cd3..a7b52fd99059 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -4802,6 +4802,28 @@ struct btrfs_uring_encoded_data {
>>>>>   	struct iov_iter iter;
>>>>>   };
>>>>> +static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
>>>>> +				    unsigned int issue_flags, int rw)
>>>>> +{
>>>>> +	struct btrfs_uring_encoded_data *data =
>>>>> +		io_uring_cmd_get_async_data(cmd)->op_data;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
>>>>> +		data->iov = NULL;
>>>>> +		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
>>>>> +						    data->args.iovcnt,
>>>>> +						    ITER_DEST, issue_flags,
>>>>> +						    &data->iter);
>>>>> +	} else {
>>>>> +		data->iov = data->iovstack;
>>>>> +		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
>>>>> +				   ARRAY_SIZE(data->iovstack), &data->iov,
>>>>> +				   &data->iter);
>>>>> +	}
>>>>> +	return ret;
>>>>> +}
>>>>
>>>> How can 'cmd' be NULL here?
>>>
>>> It seems that there is no checkes for 'cmd' before and it works same as before.
>>> But I think it's better to add a check in function start for safety.
>>
>> The check goes two lines after you already dereferenced it, and it
>> seems to be called from io_uring cmd specific code. The null check
>> only adds to confusion.
> 
> You mean 'cmd' already dereferenced for async_data. Is it okay to just
> delete code checking 'cmd' like below?
> 
> if (cmd->flags & IORING_URING_CMD_FIXED) {

Either 'cmd' may be NULL and it's valid (and the current code is fine),
or it'd be invalid, in which case that should return an error. But we
don't add random pointer == NULL checks as defensive programming. And
this one should never ever see cmd == NULL, hence the code needs to go
away. It's just confusing otherwise. Consider you reading some code
trying to understand what it does, and it has a check for cmd == NULL in
there. That would make you wonder "hmm what cases pass in a NULL for cmd
here?". When the answer is "this should never happen", don't have the
check. It just obfuscates the code.

-- 
Jens Axboe

