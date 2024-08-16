Return-Path: <linux-kernel+bounces-289718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1409954AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247851F2385D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654FA1BB69D;
	Fri, 16 Aug 2024 13:21:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93A1198851
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814518; cv=none; b=qjSmJjQIJDFfUQ4Bf7cWKyF1yHb5ks9B4UPi40y6F9N7PKgxMRysat2kEHcPS7GVZtAfgmYJEi00lofuNpVz2p5OyJbxo3EWH0TtDNVg1mMBjuDBUnGXVC00zCapAxwlb+ZpsIFmmIY5joAHDErBhXCwPGaPSLN1tOEW+IDJVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814518; c=relaxed/simple;
	bh=+ur4AjLDWgHgxkpsDSRqiaJ4I71IFqXM08mwjYc7XVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYMStiqm+aDJhyaUItlAGBcWrqq0JDy6dIgQCuMhQ5JYher2RZ9AocS+W7CUrxGF+NrpGze38ijcYrfl0BhgUn4OsProPiOMw9YWynoxWwMlOEED/6EvW/0Pwg4c89Jh46hFYNnvKO5n3+VIkZNcXBRZCRCkXy/buP9gSGjD/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F6B143D;
	Fri, 16 Aug 2024 06:22:20 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22CD63F58B;
	Fri, 16 Aug 2024 06:21:54 -0700 (PDT)
Message-ID: <ae674391-c8b1-47f9-b92f-748bf376b4a5@arm.com>
Date: Fri, 16 Aug 2024 14:21:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] perf/arm-cmn: Refactor node ID handling. Again.
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
References: <cover.1723229941.git.robin.murphy@arm.com>
 <998064aa2bdb0e39f91b4f1fea2f428689978ea9.1723229941.git.robin.murphy@arm.com>
 <Zr8c-eL1rDFDG7_O@J2N7QTR9R3> <14686473-de4a-4d43-a3d1-0df750662ca8@arm.com>
 <Zr9J1YfnPFfmS6jn@J2N7QTR9R3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Zr9J1YfnPFfmS6jn@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 1:45 pm, Mark Rutland wrote:
> On Fri, Aug 16, 2024 at 12:56:48PM +0100, Robin Murphy wrote:
>> On 2024-08-16 10:33 am, Mark Rutland wrote:
>>> Hi Robin,
>>>
>>> On Fri, Aug 09, 2024 at 08:15:40PM +0100, Robin Murphy wrote:
>>>> It transpires that despite the explicit example to the contrary in the
>>>> CMN-700 TRM, the "extra device ports" config is in fact a per-XP thing
>>>> rather than a global one. To that end, rework node IDs yet again to
>>>> carry around the additional data necessary to decode them properly. At
>>>> this point the notion of fully decomposing an ID becomes more
>>>> impractical than it's worth, so unabstracting the XY mesh coordinates
>>>> (where 2/3 users were just debug anyway) ends up leaving things a bit
>>>> simpler overall.
>>>>
>>>> Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
>>>
>>> Does this fix an observable functional issue? It's difficult to tell
>>> what the impact of this is from the commit message.
>>>
>>> i.e. what is the impact:
>>>
>>> * On the CMN-700 programmers model?
>>>
>>> * As observed by a user of the PMU driver?
>>
>> Yes, there are two areas where we functionally depend on decoding the bottom
>> 3 bits of a node ID to the individual port/device numbers. One is just for
>> the debugfs nicety, but the other is in arm_cmn_event_add() for setting
>> input_sel to the appropriate event source.
> 
> Cool; and does treating this wrong just result in getting bad values out
> in sysfs/perf, or is it possible that we have something like memory
> corruption?

Yup, it just means we'll configure the DTM to count an event input which 
most likely doesn't exist, and thus get 0, plus debugfs looks a little 
wonky, e.g.:

     1|        |
-----+--------+--------
0    | XP #0  | XP #1
      | DTC 0  | DTC 0
      |........|........
   0  |  RN-I  |  RN-D
     0|   #0   |   #0
     1|        |
   1  |  HN-T  |
     0|        |
     1|        |
   2  |        |
     0|   #1   |
     1|        |
   3  |        |
     0|        |
     1|        |
-----+--------+--------

(the HN-T node type still shows up in the right place since that comes 
directly from the per-port connect_info registers, but its corresponding 
logical ID is looked up via the node ID, thus mistakenly decoded as 
belonging to port 2 and output on the wrong line)

>> This was revealed once some hardware turned up with a mix of 3-port and
>> 2-port XPs, and events from a node at port 1 device 0 on a 2-porter were not
>> counting. It took a while to get to the "hang on, why does that ID end in
>> 0x4 not 0x2?" moment...
> 
> I see; so we were mislead by the documentation, then saw HW which
> demonstrated this.
> 
> It'd be nice to say something like:
> 
>    The CMN-700 TRM implies that the "extra device ports" configuration is
>    global to a CMN instance and the CMN PMU driver currently assumes
>    this. Unfortunately this is not correct as this configuration is
>    per-XP, and hardware exists where some XPs have extra device ports
>    while others do not.
> 
>    The presence of extra decice ports affects how the bottom 3 bits of a
>    node ID map to individual port/device numbers, and when the driver
>    misinterprets this, it may expose incorrect information in syfs, and
>    arm_cmn_event_add() may configure input_sel incorrectly, resulting in
>    incorrect performance counter numbers.
> 
>    Fix this by reworking node IDs to carry the additional data necessary
>    to decode them properly. At this point the notion of fully decomposing
>    an ID becomes more impractical than it's worth, so unabstracting the
>    XY mesh coordinates (where 2/3 users were just debug anyway) ends up
>    leaving things a bit simpler overall.
> 
> With that wording (or something very similar), this looks good to me,
> and with that:

Sure, I'll spell out the implications properly - I do tend to forget 
that the people reading these won't just be those working on the driver 
itself, but also those assessing for backports in general.

Cheers,
Robin.

> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 
>>> ... and is there anything in the manual that spells out that this is a
>>> per-XP property? I'm struggling to find that in the CMN-700 TRM, as it
>>> seems to talk about "mesh configuration(s) with extra device ports".
>>
>> That's the thing, the only suggestion is where example 3-4 strongly implies
>> it's global by going out of its way to demonstrate the 3-port format on a
>> 2-port XP, despite that being the opposite of reality. (And yes, this has
>> been raised with the documentation folks as well.)
>>
>> Thansk,
>> Robin.
>>
>>>
>>> Mark.
>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>    drivers/perf/arm-cmn.c | 94 ++++++++++++++++++------------------------
>>>>    1 file changed, 40 insertions(+), 54 deletions(-)
>>>>
>>>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>>>> index c932d9d355cf..fd2122a37f22 100644
>>>> --- a/drivers/perf/arm-cmn.c
>>>> +++ b/drivers/perf/arm-cmn.c
>>>> @@ -24,14 +24,6 @@
>>>>    #define CMN_NI_NODE_ID			GENMASK_ULL(31, 16)
>>>>    #define CMN_NI_LOGICAL_ID		GENMASK_ULL(47, 32)
>>>> -#define CMN_NODEID_DEVID(reg)		((reg) & 3)
>>>> -#define CMN_NODEID_EXT_DEVID(reg)	((reg) & 1)
>>>> -#define CMN_NODEID_PID(reg)		(((reg) >> 2) & 1)
>>>> -#define CMN_NODEID_EXT_PID(reg)		(((reg) >> 1) & 3)
>>>> -#define CMN_NODEID_1x1_PID(reg)		(((reg) >> 2) & 7)
>>>> -#define CMN_NODEID_X(reg, bits)		((reg) >> (3 + (bits)))
>>>> -#define CMN_NODEID_Y(reg, bits)		(((reg) >> 3) & ((1U << (bits)) - 1))
>>>> -
>>>>    #define CMN_CHILD_INFO			0x0080
>>>>    #define CMN_CI_CHILD_COUNT		GENMASK_ULL(15, 0)
>>>>    #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
>>>> @@ -280,8 +272,11 @@ struct arm_cmn_node {
>>>>    	u16 id, logid;
>>>>    	enum cmn_node_type type;
>>>> +	/* XP properties really, but replicated to children for convenience */
>>>>    	u8 dtm;
>>>>    	s8 dtc;
>>>> +	u8 portid_bits:4;
>>>> +	u8 deviceid_bits:4;
>>>>    	/* DN/HN-F/CXHA */
>>>>    	struct {
>>>>    		u8 val : 4;
>>>> @@ -357,49 +352,33 @@ struct arm_cmn {
>>>>    static int arm_cmn_hp_state;
>>>>    struct arm_cmn_nodeid {
>>>> -	u8 x;
>>>> -	u8 y;
>>>>    	u8 port;
>>>>    	u8 dev;
>>>>    };
>>>>    static int arm_cmn_xyidbits(const struct arm_cmn *cmn)
>>>>    {
>>>> -	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1) | 2);
>>>> +	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1));
>>>>    }
>>>> -static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn *cmn, u16 id)
>>>> +static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn_node *dn)
>>>>    {
>>>>    	struct arm_cmn_nodeid nid;
>>>> -	if (cmn->num_xps == 1) {
>>>> -		nid.x = 0;
>>>> -		nid.y = 0;
>>>> -		nid.port = CMN_NODEID_1x1_PID(id);
>>>> -		nid.dev = CMN_NODEID_DEVID(id);
>>>> -	} else {
>>>> -		int bits = arm_cmn_xyidbits(cmn);
>>>> -
>>>> -		nid.x = CMN_NODEID_X(id, bits);
>>>> -		nid.y = CMN_NODEID_Y(id, bits);
>>>> -		if (cmn->ports_used & 0xc) {
>>>> -			nid.port = CMN_NODEID_EXT_PID(id);
>>>> -			nid.dev = CMN_NODEID_EXT_DEVID(id);
>>>> -		} else {
>>>> -			nid.port = CMN_NODEID_PID(id);
>>>> -			nid.dev = CMN_NODEID_DEVID(id);
>>>> -		}
>>>> -	}
>>>> +	nid.dev = dn->id & ((1U << dn->deviceid_bits) - 1);
>>>> +	nid.port = (dn->id >> dn->deviceid_bits) & ((1U << dn->portid_bits) - 1);
>>>>    	return nid;
>>>>    }
>>>>    static struct arm_cmn_node *arm_cmn_node_to_xp(const struct arm_cmn *cmn,
>>>>    					       const struct arm_cmn_node *dn)
>>>>    {
>>>> -	struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
>>>> -	int xp_idx = cmn->mesh_x * nid.y + nid.x;
>>>> +	int id = dn->id >> (dn->portid_bits + dn->deviceid_bits);
>>>> +	int bits = arm_cmn_xyidbits(cmn);
>>>> +	int x = id > bits;
>>>> +	int y = id & ((1U << bits) - 1);
>>>> -	return cmn->xps + xp_idx;
>>>> +	return cmn->xps + cmn->mesh_x * y + x;
>>>>    }
>>>>    static struct arm_cmn_node *arm_cmn_node(const struct arm_cmn *cmn,
>>>>    					 enum cmn_node_type type)
>>>> @@ -485,13 +464,13 @@ static const char *arm_cmn_device_type(u8 type)
>>>>    	}
>>>>    }
>>>> -static void arm_cmn_show_logid(struct seq_file *s, int x, int y, int p, int d)
>>>> +static void arm_cmn_show_logid(struct seq_file *s, const struct arm_cmn_node *xp, int p, int d)
>>>>    {
>>>>    	struct arm_cmn *cmn = s->private;
>>>>    	struct arm_cmn_node *dn;
>>>> +	u16 id = xp->id | d | (p << xp->deviceid_bits);
>>>>    	for (dn = cmn->dns; dn->type; dn++) {
>>>> -		struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
>>>>    		int pad = dn->logid < 10;
>>>>    		if (dn->type == CMN_TYPE_XP)
>>>> @@ -500,7 +479,7 @@ static void arm_cmn_show_logid(struct seq_file *s, int x, int y, int p, int d)
>>>>    		if (dn->type < CMN_TYPE_HNI)
>>>>    			continue;
>>>> -		if (nid.x != x || nid.y != y || nid.port != p || nid.dev != d)
>>>> +		if (dn->id != id)
>>>>    			continue;
>>>>    		seq_printf(s, " %*c#%-*d  |", pad + 1, ' ', 3 - pad, dn->logid);
>>>> @@ -521,6 +500,7 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
>>>>    	y = cmn->mesh_y;
>>>>    	while (y--) {
>>>>    		int xp_base = cmn->mesh_x * y;
>>>> +		struct arm_cmn_node *xp = cmn->xps + xp_base;
>>>>    		u8 port[CMN_MAX_PORTS][CMN_MAX_DIMENSION];
>>>>    		for (x = 0; x < cmn->mesh_x; x++)
>>>> @@ -528,16 +508,14 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
>>>>    		seq_printf(s, "\n%-2d   |", y);
>>>>    		for (x = 0; x < cmn->mesh_x; x++) {
>>>> -			struct arm_cmn_node *xp = cmn->xps + xp_base + x;
>>>> -
>>>>    			for (p = 0; p < CMN_MAX_PORTS; p++)
>>>> -				port[p][x] = arm_cmn_device_connect_info(cmn, xp, p);
>>>> +				port[p][x] = arm_cmn_device_connect_info(cmn, xp + x, p);
>>>>    			seq_printf(s, " XP #%-3d|", xp_base + x);
>>>>    		}
>>>>    		seq_puts(s, "\n     |");
>>>>    		for (x = 0; x < cmn->mesh_x; x++) {
>>>> -			s8 dtc = cmn->xps[xp_base + x].dtc;
>>>> +			s8 dtc = xp[x].dtc;
>>>>    			if (dtc < 0)
>>>>    				seq_puts(s, " DTC ?? |");
>>>> @@ -554,10 +532,10 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
>>>>    				seq_puts(s, arm_cmn_device_type(port[p][x]));
>>>>    			seq_puts(s, "\n    0|");
>>>>    			for (x = 0; x < cmn->mesh_x; x++)
>>>> -				arm_cmn_show_logid(s, x, y, p, 0);
>>>> +				arm_cmn_show_logid(s, xp + x, p, 0);
>>>>    			seq_puts(s, "\n    1|");
>>>>    			for (x = 0; x < cmn->mesh_x; x++)
>>>> -				arm_cmn_show_logid(s, x, y, p, 1);
>>>> +				arm_cmn_show_logid(s, xp + x, p, 1);
>>>>    		}
>>>>    		seq_puts(s, "\n-----+");
>>>>    	}
>>>> @@ -1815,10 +1793,7 @@ static int arm_cmn_event_init(struct perf_event *event)
>>>>    	}
>>>>    	if (!hw->num_dns) {
>>>> -		struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, nodeid);
>>>> -
>>>> -		dev_dbg(cmn->dev, "invalid node 0x%x (%d,%d,%d,%d) type 0x%x\n",
>>>> -			nodeid, nid.x, nid.y, nid.port, nid.dev, type);
>>>> +		dev_dbg(cmn->dev, "invalid node 0x%x type 0x%x\n", nodeid, type);
>>>>    		return -EINVAL;
>>>>    	}
>>>> @@ -1921,7 +1896,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>>>>    			arm_cmn_claim_wp_idx(dtm, event, d, wp_idx, i);
>>>>    			writel_relaxed(cfg, dtm->base + CMN_DTM_WPn_CONFIG(wp_idx));
>>>>    		} else {
>>>> -			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
>>>> +			struct arm_cmn_nodeid nid = arm_cmn_nid(dn);
>>>>    			if (cmn->multi_dtm)
>>>>    				nid.port %= 2;
>>>> @@ -2168,10 +2143,12 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
>>>>    			continue;
>>>>    		xp = arm_cmn_node_to_xp(cmn, dn);
>>>> +		dn->portid_bits = xp->portid_bits;
>>>> +		dn->deviceid_bits = xp->deviceid_bits;
>>>>    		dn->dtc = xp->dtc;
>>>>    		dn->dtm = xp->dtm;
>>>>    		if (cmn->multi_dtm)
>>>> -			dn->dtm += arm_cmn_nid(cmn, dn->id).port / 2;
>>>> +			dn->dtm += arm_cmn_nid(dn).port / 2;
>>>>    		if (dn->type == CMN_TYPE_DTC) {
>>>>    			int err = arm_cmn_init_dtc(cmn, dn, dtc_idx++);
>>>> @@ -2341,18 +2318,27 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>>>    		arm_cmn_init_dtm(dtm++, xp, 0);
>>>>    		/*
>>>>    		 * Keeping track of connected ports will let us filter out
>>>> -		 * unnecessary XP events easily. We can also reliably infer the
>>>> -		 * "extra device ports" configuration for the node ID format
>>>> -		 * from this, since in that case we will see at least one XP
>>>> -		 * with port 2 connected, for the HN-D.
>>>> +		 * unnecessary XP events easily, and also infer the per-XP
>>>> +		 * part of the node ID format.
>>>>    		 */
>>>>    		for (int p = 0; p < CMN_MAX_PORTS; p++)
>>>>    			if (arm_cmn_device_connect_info(cmn, xp, p))
>>>>    				xp_ports |= BIT(p);
>>>> -		if (cmn->multi_dtm && (xp_ports & 0xc))
>>>> +		if (cmn->num_xps == 1) {
>>>> +			xp->portid_bits = 3;
>>>> +			xp->deviceid_bits = 2;
>>>> +		} else if (xp_ports > 0x3) {
>>>> +			xp->portid_bits = 2;
>>>> +			xp->deviceid_bits = 1;
>>>> +		} else {
>>>> +			xp->portid_bits = 1;
>>>> +			xp->deviceid_bits = 2;
>>>> +		}
>>>> +
>>>> +		if (cmn->multi_dtm && (xp_ports > 0x3))
>>>>    			arm_cmn_init_dtm(dtm++, xp, 1);
>>>> -		if (cmn->multi_dtm && (xp_ports & 0x30))
>>>> +		if (cmn->multi_dtm && (xp_ports > 0xf))
>>>>    			arm_cmn_init_dtm(dtm++, xp, 2);
>>>>    		cmn->ports_used |= xp_ports;
>>>> -- 
>>>> 2.39.2.101.g768bb238c484.dirty
>>>>

