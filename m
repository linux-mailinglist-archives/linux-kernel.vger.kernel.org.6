Return-Path: <linux-kernel+bounces-554277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CFFA595A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647793A724E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3C7229B0D;
	Mon, 10 Mar 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr3W7lX+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C5C227EA0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612154; cv=none; b=Kyq5ia6RvWy8E75TL01bmtU6E/lJ8Gp8gpgK3xO3aoeHo+DSMIpoxH+1oWKXrBPga449wTRe37VKiQ9fNj3jEc/wQe9AcF2dkh6z3nM5UqpygAA9QbFdqNAVyqv6hd5dv0J7BaYTk9zF1oZz+ZFXDmEatNkGZ3+sr1WwNb0OUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612154; c=relaxed/simple;
	bh=Vq+v5sP4eqDziClAZd6XjfUr7QO/4X4D/kFCPmbk2aw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZMADrTbCyLbjbJQeXVJ4ONwwzQsMzGPVMwC6b7Me/CfUgloTN0Or2E4Kr1POlDojGpQ6myGN5aY5AXjfjAlGOAnSEy63QBihNtbOPNpOAt2nAYmgP+fLRXZmJBNyv9yMAk+fHKkm/nffSvCPik9GPNkEGu99Yvq+8xfAtxunI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vr3W7lX+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741612153; x=1773148153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vq+v5sP4eqDziClAZd6XjfUr7QO/4X4D/kFCPmbk2aw=;
  b=Vr3W7lX+mrZmQ03abQzg5/eRVT60igEzmqIX+3Zgx4pG0f/EfZ4u7Fjb
   viygj26baGxRP0NeL/V7u5OxrARG7stBx9dosHMuZCd7+aX33FcJ6Qtzv
   W+yqk5hVY0CKYQdKnKWbCixmlGUJCcbE0mzVX5eek2sus9KIhLh+ipkin
   /SShZGg3jp9qoi0LtiLxGfGaYLxC6a1ULZmVEqIjo0IxqmcmgawoPtms/
   FJKK9/WUXO5ZcI35m+dGx27ur8iCC7xbnBZdLTlMvR8oXQaJSnxxBZTGW
   wPWM9J0E/z1x28UNXXc++34JI2+2jppamiU+k0fZ6sXoBI4qI2xdl8zOl
   g==;
X-CSE-ConnectionGUID: LlOSiDmbR32H7c+IhVkEsw==
X-CSE-MsgGUID: f1euYP8JRaC8uIoyd/Rjaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42515507"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42515507"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 06:09:12 -0700
X-CSE-ConnectionGUID: Lzhp/OENQxuRbABCjpzBwQ==
X-CSE-MsgGUID: YdsDAS0nR/eXQm8MGMvmkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="125043995"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 10 Mar 2025 06:09:10 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trcsW-0004GC-2Z;
	Mon, 10 Mar 2025 13:09:08 +0000
Date: Mon, 10 Mar 2025 21:08:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250304 5/11]
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:31: error: field 'tx' has
 incomplete type
Message-ID: <202503102143.Rm06fBbo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250304
head:   6d2e9e1f723433e96db706772bc630bc704bf9ba
commit: a6053266a6e573a3c22309605547bf35869fbaf3 [5/11] wifi: iwlwifi: dvm: Avoid -Wflex-array-member-not-at-end warnings
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20250310/202503102143.Rm06fBbo-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503102143.Rm06fBbo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503102143.Rm06fBbo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/pcie/tx.c:27:
>> drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:31: error: field 'tx' has incomplete type
     745 |         struct iwl_tx_cmd_hdr tx;
         |                               ^~
   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:764:31: error: field 'tx' has incomplete type
     764 |         struct iwl_tx_cmd_hdr tx;
         |                               ^~
--
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:10,
                    from drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h:10,
                    from drivers/net/wireless/intel/iwlwifi/mvm/sta.h:15,
                    from drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:30,
                    from drivers/net/wireless/intel/iwlwifi/mvm/fw.c:21:
>> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:31: error: field 'tx' has incomplete type
     745 |         struct iwl_tx_cmd_hdr tx;
         |                               ^~
   drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:764:31: error: field 'tx' has incomplete type
     764 |         struct iwl_tx_cmd_hdr tx;
         |                               ^~
>> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:53:31: error: field 'tx_cmd' has incomplete type
      53 |         struct iwl_tx_cmd_hdr tx_cmd;
         |                               ^~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:134:31: error: field 'pti_req_tx_cmd' has incomplete type
     134 |         struct iwl_tx_cmd_hdr pti_req_tx_cmd;
         |                               ^~~~~~~~~~~~~~


vim +/tx +745 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h

   686	
   687	/**
   688	 * struct iwl_compressed_ba_notif - notifies about reception of BA
   689	 * ( BA_NOTIF = 0xc5 )
   690	 * @flags: status flag, see the &iwl_mvm_ba_resp_flags
   691	 * @sta_id: Index of recipient (BA-sending) station in fw's station table
   692	 * @reduced_txp: power reduced according to TPC. This is the actual value and
   693	 *	not a copy from the LQ command. Thus, if not the first rate was used
   694	 *	for Tx-ing then this value will be set to 0 by FW.
   695	 * @tlc_rate_info: TLC rate info, initial rate index, TLC table color
   696	 * @retry_cnt: retry count
   697	 * @query_byte_cnt: SCD query byte count
   698	 * @query_frame_cnt: SCD query frame count
   699	 * @txed: number of frames sent in the aggregation (all-TIDs)
   700	 * @done: number of frames that were Acked by the BA (all-TIDs)
   701	 * @rts_retry_cnt: RTS retry count
   702	 * @reserved: reserved (for alignment)
   703	 * @wireless_time: Wireless-media time
   704	 * @tx_rate: the rate the aggregation was sent at
   705	 * @tfd_cnt: number of TFD-Q elements
   706	 * @ra_tid_cnt: number of RATID-Q elements
   707	 * @tfd: array of TFD queue status updates. See &iwl_compressed_ba_tfd
   708	 *	for details. Length in @tfd_cnt.
   709	 * @ra_tid: array of RA-TID queue status updates. For debug purposes only. See
   710	 *	&iwl_compressed_ba_ratid for more details. Length in @ra_tid_cnt.
   711	 */
   712	struct iwl_compressed_ba_notif {
   713		__le32 flags;
   714		u8 sta_id;
   715		u8 reduced_txp;
   716		u8 tlc_rate_info;
   717		u8 retry_cnt;
   718		__le32 query_byte_cnt;
   719		__le16 query_frame_cnt;
   720		__le16 txed;
   721		__le16 done;
   722		u8 rts_retry_cnt;
   723		u8 reserved;
   724		__le32 wireless_time;
   725		__le32 tx_rate;
   726		__le16 tfd_cnt;
   727		__le16 ra_tid_cnt;
   728		union {
   729			DECLARE_FLEX_ARRAY(struct iwl_compressed_ba_ratid, ra_tid);
   730			DECLARE_FLEX_ARRAY(struct iwl_compressed_ba_tfd, tfd);
   731		};
   732	} __packed; /* COMPRESSED_BA_RES_API_S_VER_4,
   733		       COMPRESSED_BA_RES_API_S_VER_5 */
   734	
   735	/**
   736	 * struct iwl_mac_beacon_cmd_v6 - beacon template command
   737	 * @tx: the tx commands associated with the beacon frame
   738	 * @template_id: currently equal to the mac context id of the coresponding
   739	 *  mac.
   740	 * @tim_idx: the offset of the tim IE in the beacon
   741	 * @tim_size: the length of the tim IE
   742	 * @frame: the template of the beacon frame
   743	 */
   744	struct iwl_mac_beacon_cmd_v6 {
 > 745		struct iwl_tx_cmd_hdr tx;
   746		__le32 template_id;
   747		__le32 tim_idx;
   748		__le32 tim_size;
   749		struct ieee80211_hdr frame[];
   750	} __packed; /* BEACON_TEMPLATE_CMD_API_S_VER_6 */
   751	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

