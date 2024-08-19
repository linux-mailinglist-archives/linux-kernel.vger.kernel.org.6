Return-Path: <linux-kernel+bounces-291881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C8E95687E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6471C21A83
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E9F161900;
	Mon, 19 Aug 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BeN+dx32";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CpQibbTg"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C21607B6;
	Mon, 19 Aug 2024 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063269; cv=none; b=VXXPMUtolMB10zz2UWkF+Xz3KT+7bDjNqiAuS05Bw/QmAzH9dmcoRSp6fx18OK+pgIzb80/vHf01wckuEQlOpYoSDRNMe9+bKHiDW0UebuI6WpNmWiF4ADuqHPm8+GvuN9gY/oDBvvcG785dlz2MK1a9PcApJ+YoFVR6Fmj70mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063269; c=relaxed/simple;
	bh=plLGPglChIZScl+bPcBfPD0a+qQy5CR775VUcS5NIvk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z9eCk5dmIscmApTvGASGmGrDcqqZryDD9eJjdYm0djbaMFU1fSR9DvaDFyILm61pavu281FSKGfVrWXzY8urij5nCOEkvkpoLYZpLMXgacXyCDsg086XOl7bwrOfU4CR0Z9hiCLnBoRv4JXUy/OaWnNTCSSi5ajH5XzLgOgnVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BeN+dx32; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CpQibbTg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id E0BF2138FFAA;
	Mon, 19 Aug 2024 06:27:45 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 19 Aug 2024 06:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724063265;
	 x=1724149665; bh=bhTVX/HRQH/OPQQfydRTlbdnxplGMJyUVJyuYI37RzQ=; b=
	BeN+dx32MGA/Ow2lOvi02RQgeLczoSutur8V+EwYe1N9mJ8rmTI5TE8II5laYUdY
	Zm6iWMp6acHdfVwke9yNAAdY5Ff0hiBzfhH5PTB5iTmRQfnnLcx37aR5jM5Y/gDm
	NSdaAhjyusDD7euw4ioyQgmcdqRW5ugRojb6eLzM1JXdrU0KK/mhRJIoDlnNQdeG
	EZ3rmVtkg7R7cK0UFABJArdo1Z5mSpCt4SeP/mHf7y2T2QP6jeFb67auQBvXnYzG
	7Mgt/OOneqiVvNG5/Wz8KLBUW6nxCkCgT3RLzn17qzr7wvjkHsHyoLYnk3cXIPkD
	YfTUTA+MYl82sZJhINnR7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724063265; x=
	1724149665; bh=bhTVX/HRQH/OPQQfydRTlbdnxplGMJyUVJyuYI37RzQ=; b=C
	pQibbTgyP8aCn1fuwDqeG7Bs9Jyuz2EQhftjt2eTnSDUpqITjecKTFeCx+8ebhTs
	DUN5iMdnCWvTrZ6+pUW6c+4ps6IYnHTWdUxGRGRkzBCfbufo9rKJUFi2IqM0+awX
	W54j6rHnxXuE8g6MZjGQFzHfbZZQPcnTBRq6VkDxCk+UoFn7Z2xbGPD3sX8gFayI
	f1R88nWTMhjrnoXeMnjlqdEEBDCuROoQqupC8D7xjG1e1cynoE2zqON0Sf8+Pc6Z
	CP7I4ppbFjRZy98eWb4Rj32vm+WsQdmhhT/huRPQN1cWuoSvrKdu+z4p9VbGEbAy
	qpQe7a/j2IqTdgLrr8xAA==
X-ME-Sender: <xms:IR7DZutw0ZImf23FdAu24Kni5evGImEnNpuQnX8N7QkYbh3DcHly-g>
    <xme:IR7DZjdSOtm3tuep2-YK_XadIO0vjvCSustNWH8V9EvhdCw-0UJfCVE0muV4yTubP
    DEkw4YsJewMOdxKxTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkshhhrgihrdhguhhpthgrsegrmh
    gurdgtohhmpdhrtghpthhtohepnhgrvhgvvghnkhhrihhshhhnrgdrtghhrghtrhgrughh
    ihesrghmugdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehrohgvtghkqdhushdrnhgvthdp
    rhgtphhtthhopehlihhnuhigqdhhfihmohhnsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IR7DZpzDxlfp657TlpUP5RziRlRz2wWJinewxg80CgRudKiltoSanQ>
    <xmx:IR7DZpPdEtSB2aQFSwAr9rF0pa2jegXmUDATxOyBkXFCifzgvIEovQ>
    <xmx:IR7DZu8t4jjlXqS1EzcCsXU2N8yz2HehvLj6_y-khq4WTdyGPiqDZA>
    <xmx:IR7DZhXlzIja3wMoqMZL4Lca4E-kAJnNODSbmrB0EOhlSCFGcY1qtg>
    <xmx:IR7DZllKY4UpIxp5R5oK1UE1yE05SBKrRN73sWKjUEA-ClxBUyoOCmu7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7865516005E; Mon, 19 Aug 2024 06:27:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Aug 2024 12:27:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Akshay Gupta" <akshay.gupta@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 naveenkrishna.chatradhi@amd.com
Message-Id: <60a9e4a7-6a72-4aec-88f3-e705f0ae156a@app.fastmail.com>
In-Reply-To: <20240814095954.2359863-6-akshay.gupta@amd.com>
References: <20240814095954.2359863-1-akshay.gupta@amd.com>
 <20240814095954.2359863-6-akshay.gupta@amd.com>
Subject: Re: [PATCH v3 5/8] misc: amd-sbi: Add support for CPUID protocol
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 14, 2024, at 11:59, Akshay Gupta wrote:

> +/* input for bulk write to CPUID protocol */
> +struct cpu_msr_indata {
> +	u8 wr_len;	/* const value */
> +	u8 rd_len;	/* const value */
> +	u8 proto_cmd;	/* const value */
> +	u8 thread;	/* thread number */
> +	union {
> +		u8 reg_offset[4];	/* input value */
> +		u32 value;
> +	};
> +	u8 ext; /* extended function */
> +} __packed;

You cannot have a fully aligned union inside of a misaligned
struct. Since the only member is the inner 'u32 value',
I think it would make more sense to make that one
__packed instead of the structure.

> +/* output for bulk read from CPUID protocol */
> +struct cpu_msr_outdata {
> +	u8 num_bytes;	/* number of bytes return */
> +	u8 status;	/* Protocol status code */
> +	union {
> +		u64 value;
> +		u8 reg_data[8];
> +	};
> +} __packed;

Same here.

> +#define prepare_cpuid_input_message(input, thread_id, func, ext_func)	\
> +	input.rd_len = CPUID_RD_DATA_LEN,				\
> +	input.wr_len = CPUID_WR_DATA_LEN,				\
> +	input.proto_cmd = RD_CPUID_CMD,					\
> +	input.thread = thread_id << 1,					\
> +	input.value =  func,						\
> +	input.ext =  ext_func

This can be an inline function.

> +/*
> + * For Mailbox command software alert status bit is set by firmware
> + * to indicate command completion
> + * For RMI Rev 0x20, new h/w status bit is introduced. which is used
> + * by firmware to indicate completion of commands (0x71, 0x72, 0x73).
> + * wait for the status bit to be set by the firmware before
> + * reading the data out.
> + */
> +static int sbrmi_wait_status(struct sbrmi_data *data,
> +			     int *status, int mask)
> +{
> +	int ret, retry = 100;
> +
> +	do {
> +		ret = regmap_read(data->regmap, SBRMI_STATUS, status);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (*status & mask)
> +			break;
> +
> +		/* Wait 1~2 second for firmware to return data out */
> +		if (retry > 95)
> +			usleep_range(50, 100);
> +		else
> +			usleep_range(10000, 20000);
> +	} while (retry--);

This loop is likely to take much longer than 2 seconds if it
times out because of all the rounding etc.

You can probably change this to regmap_read_poll_timeout(),
which handles timeouts correctly.

> +/* command ID to identify CPUID protocol */
> +#define APML_CPUID	0x1000
>  /* These are byte indexes into data_in and data_out arrays */
>  #define AMD_SBI_RD_WR_DATA_INDEX	0
>  #define AMD_SBI_REG_OFF_INDEX		0
>  #define AMD_SBI_REG_VAL_INDEX		4
>  #define AMD_SBI_RD_FLAG_INDEX		7
> +#define AMD_SBI_THREAD_LOW_INDEX	4
> +#define AMD_SBI_THREAD_HI_INDEX		5
> +#define AMD_SBI_EXT_FUNC_INDEX		6
> 
>  #define AMD_SBI_MB_DATA_SIZE		4
> 
>  struct apml_message {
>  	/* message ids:
>  	 * Mailbox Messages:	0x0 ... 0x999
> +	 * APML_CPUID:		0x1000
>  	 */
>  	__u32 cmd;
> 
>  	/*
>  	 * 8 bit data for reg read,
>  	 * 32 bit data in case of mailbox,
> +	 * up to 64 bit in case of cpuid
>  	 */
>  	union {
> +		__u64 cpu_msr_out;
>  		__u32 mb_out[2];
>  		__u8 reg_out[8];
>  	} data_out;
> 
>  	/*
>  	 * [0]...[3] mailbox 32bit input
> +	 *	     cpuid,
> +	 * [4][5] cpuid: thread
> +	 * [6] cpuid: ext function & read eax/ebx or ecx/edx
> +	 *	[7:0] -> bits [7:4] -> ext function &
> +	 *	bit [0] read eax/ebx or ecx/edx
>  	 * [7] read/write functionality
>  	 */
>  	union {
> +		__u64 cpu_msr_in;
>  		__u32 mb_in[2];
>  		__u8 reg_in[8];
>  	} data_in;
>  	/*
> +	 * Status code is returned in case of CPUID access
>  	 * Error code is returned in case of soft mailbox
>  	 */
>  	__u32 fw_ret_code;

Low-level protocols like this are rarely a good idea to be
exported to userspace. I can't see what the exact data is
that you can get in and out, but you probably want higher-level
interfaces for the individual things the platform interface
can do, either hooking up to existing kernel subsystems or
as separate user space interfaces.

     Arnd

