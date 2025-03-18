Return-Path: <linux-kernel+bounces-566942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF3A67EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A89D8824A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2B17A304;
	Tue, 18 Mar 2025 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWZPt2EP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5E169AE6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333459; cv=none; b=VoMBoIS3ILY5UqklnuG7Pc8I0L0H2LsRbddztQwRw0cELtI1fMMwDiB0s6z4Lf7JsJNsPFZ+k+YVY3QsTV+R7uNLDrTi99Q3cg41U3+sVhnKZGnhtigtrXcapgaViZWqN21Yk1ia+/Dxm0WFQgJFToQ8iQ4YzhW93xiVUfewKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333459; c=relaxed/simple;
	bh=MRnXVEQjjci73FxYWvmmLKP5Z1/DVNZ8boeyGX0lTi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tENjUC8ekNz3LKtKBH7JnNc3ko55+hYVVTaLhWv0g1QsilJ+8lORSOxBDPp4DgVYfwD5xxIHC0zkzBE+yKcc3OL9Rwf7sgmW3FPoUi5yyv3jE6APfl43K8lG38rrwzAeL77lwMmNAtiwAciwLMhLPzIeJVAAr/193i+ddcSxcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWZPt2EP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742333456; x=1773869456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MRnXVEQjjci73FxYWvmmLKP5Z1/DVNZ8boeyGX0lTi0=;
  b=YWZPt2EP/AJbgbyaYyskOImNqCDkVHKRMVh9onRp7eLOmsWr+qgDcWAZ
   O2HGoPRSQH0MPdnrZbhvx0uduJAjdLSq+hGGr/DBppkUknFJgNLrVRkLD
   ukOS7kUp25Uc5AR1c56t/1z3Z494vXTuiL4SrdGz85FXOOt7NPYFnlmyH
   Yf7BUP5OwQkwj6YD8Ds//jx2A2caHjMbIMIraWS7Gt7rZ11Q1kmgCqRTF
   Ay2SDXS6XA2ABHmI4SYrBB2r41nHOw0oa61S+Z//qoovrFPK0B4czMRGL
   2qIg93wliOa5SD9k/hmofCeHvIdRA3udkviue3HSR7DN2yhekVLghc34H
   g==;
X-CSE-ConnectionGUID: e1QoSFCURNelwqS4HFEhkw==
X-CSE-MsgGUID: kgiaBmg0R2SiIKY+zfFH5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42670984"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="42670984"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:30:56 -0700
X-CSE-ConnectionGUID: c7Ek22+0R7WG4mj/9VQRuA==
X-CSE-MsgGUID: cbNQjiBNQvqBEM5+RQYYPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="127490718"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 18 Mar 2025 14:30:54 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tueWR-000EBc-2i;
	Tue, 18 Mar 2025 21:30:51 +0000
Date: Wed, 19 Mar 2025 05:30:30 +0800
From: kernel test robot <lkp@intel.com>
To: Dorcas Anono Litunya <anonolitunya@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/test-drivers/vivid/vivid-ctrls.c:1799:22: warning: '
 Is Connected To' directive output may be truncated writing 16 bytes into a
 region of size between 10 and 19
Message-ID: <202503190528.0rJE681f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81e4f8d68c66da301bb881862735bd74c6241a19
commit: d7c969f37515d78dc1a026d12b94b90e319a5a61 media: vivid: Add 'Is Connected To' menu controls
date:   9 months ago
config: riscv-randconfig-r123-20250318 (https://download.01.org/0day-ci/archive/20250319/202503190528.0rJE681f-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250319/202503190528.0rJE681f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503190528.0rJE681f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/test-drivers/vivid/vivid-ctrls.c: In function 'vivid_create_controls':
>> drivers/media/test-drivers/vivid/vivid-ctrls.c:1799:22: warning: ' Is Connected To' directive output may be truncated writing 16 bytes into a region of size between 10 and 19 [-Wformat-truncation=]
         "S-Video %03u-%u Is Connected To", dev->inst, i);
                         ^~~~~~~~~~~~~~~~
   drivers/media/test-drivers/vivid/vivid-ctrls.c:1797:4: note: 'snprintf' output between 30 and 39 bytes into a destination of size 32
       snprintf(dev->ctrl_svid_to_output_names[i],
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         sizeof(dev->ctrl_svid_to_output_names[i]),
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "S-Video %03u-%u Is Connected To", dev->inst, i);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/test-drivers/vivid/vivid-ctrls.c:1780:19: warning: ' Is Connected To' directive output may be truncated writing 16 bytes into a region of size between 13 and 22 [-Wformat-truncation=]
         "HDMI %03u-%u Is Connected To", dev->inst, i);
                      ^~~~~~~~~~~~~~~~
   drivers/media/test-drivers/vivid/vivid-ctrls.c:1778:4: note: 'snprintf' output between 27 and 36 bytes into a destination of size 32
       snprintf(dev->ctrl_hdmi_to_output_names[i],
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         sizeof(dev->ctrl_hdmi_to_output_names[i]),
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "HDMI %03u-%u Is Connected To", dev->inst, i);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1799 drivers/media/test-drivers/vivid/vivid-ctrls.c

  1635	
  1636	int vivid_create_controls(struct vivid_dev *dev, bool show_ccs_cap,
  1637			bool show_ccs_out, bool no_error_inj,
  1638			bool has_sdtv, bool has_hdmi)
  1639	{
  1640		struct v4l2_ctrl_handler *hdl_user_gen = &dev->ctrl_hdl_user_gen;
  1641		struct v4l2_ctrl_handler *hdl_user_vid = &dev->ctrl_hdl_user_vid;
  1642		struct v4l2_ctrl_handler *hdl_user_aud = &dev->ctrl_hdl_user_aud;
  1643		struct v4l2_ctrl_handler *hdl_streaming = &dev->ctrl_hdl_streaming;
  1644		struct v4l2_ctrl_handler *hdl_sdtv_cap = &dev->ctrl_hdl_sdtv_cap;
  1645		struct v4l2_ctrl_handler *hdl_loop_cap = &dev->ctrl_hdl_loop_cap;
  1646		struct v4l2_ctrl_handler *hdl_fb = &dev->ctrl_hdl_fb;
  1647		struct v4l2_ctrl_handler *hdl_vid_cap = &dev->ctrl_hdl_vid_cap;
  1648		struct v4l2_ctrl_handler *hdl_vid_out = &dev->ctrl_hdl_vid_out;
  1649		struct v4l2_ctrl_handler *hdl_vbi_cap = &dev->ctrl_hdl_vbi_cap;
  1650		struct v4l2_ctrl_handler *hdl_vbi_out = &dev->ctrl_hdl_vbi_out;
  1651		struct v4l2_ctrl_handler *hdl_radio_rx = &dev->ctrl_hdl_radio_rx;
  1652		struct v4l2_ctrl_handler *hdl_radio_tx = &dev->ctrl_hdl_radio_tx;
  1653		struct v4l2_ctrl_handler *hdl_sdr_cap = &dev->ctrl_hdl_sdr_cap;
  1654		struct v4l2_ctrl_handler *hdl_meta_cap = &dev->ctrl_hdl_meta_cap;
  1655		struct v4l2_ctrl_handler *hdl_meta_out = &dev->ctrl_hdl_meta_out;
  1656		struct v4l2_ctrl_handler *hdl_tch_cap = &dev->ctrl_hdl_touch_cap;
  1657	
  1658		struct v4l2_ctrl_config vivid_ctrl_dv_timings = {
  1659			.ops = &vivid_vid_cap_ctrl_ops,
  1660			.id = VIVID_CID_DV_TIMINGS,
  1661			.name = "DV Timings",
  1662			.type = V4L2_CTRL_TYPE_MENU,
  1663		};
  1664		int i;
  1665	
  1666		v4l2_ctrl_handler_init(hdl_user_gen, 10);
  1667		v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_class, NULL);
  1668		v4l2_ctrl_handler_init(hdl_user_vid, 9);
  1669		v4l2_ctrl_new_custom(hdl_user_vid, &vivid_ctrl_class, NULL);
  1670		v4l2_ctrl_handler_init(hdl_user_aud, 2);
  1671		v4l2_ctrl_new_custom(hdl_user_aud, &vivid_ctrl_class, NULL);
  1672		v4l2_ctrl_handler_init(hdl_streaming, 8);
  1673		v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_class, NULL);
  1674		v4l2_ctrl_handler_init(hdl_sdtv_cap, 2);
  1675		v4l2_ctrl_new_custom(hdl_sdtv_cap, &vivid_ctrl_class, NULL);
  1676		v4l2_ctrl_handler_init(hdl_loop_cap, 1);
  1677		v4l2_ctrl_new_custom(hdl_loop_cap, &vivid_ctrl_class, NULL);
  1678		v4l2_ctrl_handler_init(hdl_fb, 1);
  1679		v4l2_ctrl_new_custom(hdl_fb, &vivid_ctrl_class, NULL);
  1680		v4l2_ctrl_handler_init(hdl_vid_cap, 55);
  1681		v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_class, NULL);
  1682		v4l2_ctrl_handler_init(hdl_vid_out, 26);
  1683		if (!no_error_inj || dev->has_fb || dev->num_hdmi_outputs)
  1684			v4l2_ctrl_new_custom(hdl_vid_out, &vivid_ctrl_class, NULL);
  1685		v4l2_ctrl_handler_init(hdl_vbi_cap, 21);
  1686		v4l2_ctrl_new_custom(hdl_vbi_cap, &vivid_ctrl_class, NULL);
  1687		v4l2_ctrl_handler_init(hdl_vbi_out, 19);
  1688		if (!no_error_inj)
  1689			v4l2_ctrl_new_custom(hdl_vbi_out, &vivid_ctrl_class, NULL);
  1690		v4l2_ctrl_handler_init(hdl_radio_rx, 17);
  1691		v4l2_ctrl_new_custom(hdl_radio_rx, &vivid_ctrl_class, NULL);
  1692		v4l2_ctrl_handler_init(hdl_radio_tx, 17);
  1693		v4l2_ctrl_new_custom(hdl_radio_tx, &vivid_ctrl_class, NULL);
  1694		v4l2_ctrl_handler_init(hdl_sdr_cap, 19);
  1695		v4l2_ctrl_new_custom(hdl_sdr_cap, &vivid_ctrl_class, NULL);
  1696		v4l2_ctrl_handler_init(hdl_meta_cap, 2);
  1697		v4l2_ctrl_new_custom(hdl_meta_cap, &vivid_ctrl_class, NULL);
  1698		v4l2_ctrl_handler_init(hdl_meta_out, 2);
  1699		v4l2_ctrl_new_custom(hdl_meta_out, &vivid_ctrl_class, NULL);
  1700		v4l2_ctrl_handler_init(hdl_tch_cap, 2);
  1701		v4l2_ctrl_new_custom(hdl_tch_cap, &vivid_ctrl_class, NULL);
  1702	
  1703		/* User Controls */
  1704		dev->volume = v4l2_ctrl_new_std(hdl_user_aud, NULL,
  1705			V4L2_CID_AUDIO_VOLUME, 0, 255, 1, 200);
  1706		dev->mute = v4l2_ctrl_new_std(hdl_user_aud, NULL,
  1707			V4L2_CID_AUDIO_MUTE, 0, 1, 1, 0);
  1708		if (dev->has_vid_cap) {
  1709			dev->brightness = v4l2_ctrl_new_std(hdl_user_vid, &vivid_user_vid_ctrl_ops,
  1710				V4L2_CID_BRIGHTNESS, 0, 255, 1, 128);
  1711			for (i = 0; i < MAX_INPUTS; i++)
  1712				dev->input_brightness[i] = 128;
  1713			dev->contrast = v4l2_ctrl_new_std(hdl_user_vid, &vivid_user_vid_ctrl_ops,
  1714				V4L2_CID_CONTRAST, 0, 255, 1, 128);
  1715			dev->saturation = v4l2_ctrl_new_std(hdl_user_vid, &vivid_user_vid_ctrl_ops,
  1716				V4L2_CID_SATURATION, 0, 255, 1, 128);
  1717			dev->hue = v4l2_ctrl_new_std(hdl_user_vid, &vivid_user_vid_ctrl_ops,
  1718				V4L2_CID_HUE, -128, 128, 1, 0);
  1719			v4l2_ctrl_new_std(hdl_user_vid, &vivid_user_vid_ctrl_ops,
  1720				V4L2_CID_HFLIP, 0, 1, 1, 0);
  1721			v4l2_ctrl_new_std(hdl_user_vid, &vivid_user_vid_ctrl_ops,
  1722				V4L2_CID_VFLIP, 0, 1, 1, 0);
  1723			dev->autogain = v4l2_ctrl_new_std(hdl_user_vid, &vivid_user_vid_ctrl_ops,
  1724				V4L2_CID_AUTOGAIN, 0, 1, 1, 1);
  1725			dev->gain = v4l2_ctrl_new_std(hdl_user_vid, &vivid_user_vid_ctrl_ops,
  1726				V4L2_CID_GAIN, 0, 255, 1, 100);
  1727			dev->alpha = v4l2_ctrl_new_std(hdl_user_vid, &vivid_user_vid_ctrl_ops,
  1728				V4L2_CID_ALPHA_COMPONENT, 0, 255, 1, 0);
  1729		}
  1730		dev->button = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_button, NULL);
  1731		dev->int32 = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_int32, NULL);
  1732		dev->int64 = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_int64, NULL);
  1733		dev->boolean = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_boolean, NULL);
  1734		dev->menu = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_menu, NULL);
  1735		dev->string = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_string, NULL);
  1736		dev->bitmask = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_bitmask, NULL);
  1737		dev->int_menu = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_int_menu, NULL);
  1738		dev->ro_int32 = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_ro_int32, NULL);
  1739		v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_area, NULL);
  1740		v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u32_array, NULL);
  1741		v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u32_dyn_array, NULL);
  1742		v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u16_matrix, NULL);
  1743		v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u8_4d_array, NULL);
  1744		dev->pixel_array = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u8_pixel_array, NULL);
  1745		v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_s32_array, NULL);
  1746		v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_s64_array, NULL);
  1747	
  1748		if (dev->has_vid_cap) {
  1749			/* Image Processing Controls */
  1750			struct v4l2_ctrl_config vivid_ctrl_test_pattern = {
  1751				.ops = &vivid_vid_cap_ctrl_ops,
  1752				.id = VIVID_CID_TEST_PATTERN,
  1753				.name = "Test Pattern",
  1754				.type = V4L2_CTRL_TYPE_MENU,
  1755				.max = TPG_PAT_NOISE,
  1756				.qmenu = tpg_pattern_strings,
  1757			};
  1758	
  1759			dev->test_pattern = v4l2_ctrl_new_custom(hdl_vid_cap,
  1760					&vivid_ctrl_test_pattern, NULL);
  1761			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_perc_fill, NULL);
  1762			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_hor_movement, NULL);
  1763			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_vert_movement, NULL);
  1764			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_osd_mode, NULL);
  1765			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_show_border, NULL);
  1766			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_show_square, NULL);
  1767			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_hflip, NULL);
  1768			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_vflip, NULL);
  1769			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_insert_sav, NULL);
  1770			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_insert_eav, NULL);
  1771			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_insert_hdmi_video_guard_band, NULL);
  1772			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_reduced_fps, NULL);
  1773	
  1774			WARN_ON(dev->num_hdmi_inputs > MAX_HDMI_INPUTS);
  1775			WARN_ON(dev->num_svid_inputs > MAX_SVID_INPUTS);
  1776	
  1777			for (u8 i = 0; i < dev->num_hdmi_inputs; i++) {
  1778				snprintf(dev->ctrl_hdmi_to_output_names[i],
  1779					 sizeof(dev->ctrl_hdmi_to_output_names[i]),
  1780					 "HDMI %03u-%u Is Connected To", dev->inst, i);
  1781			}
  1782	
  1783			for (u8 i = 0; i < dev->num_hdmi_inputs; i++) {
  1784				struct v4l2_ctrl_config ctrl_config = {
  1785					.ops = &vivid_vid_cap_ctrl_ops,
  1786					.id = VIVID_CID_HDMI_IS_CONNECTED_TO_OUTPUT(i),
  1787					.name = dev->ctrl_hdmi_to_output_names[i],
  1788					.type = V4L2_CTRL_TYPE_MENU,
  1789					.max = 1,
  1790					.qmenu = (const char * const *)vivid_ctrl_hdmi_to_output_strings,
  1791				};
  1792				dev->ctrl_hdmi_to_output[i] = v4l2_ctrl_new_custom(hdl_vid_cap,
  1793										   &ctrl_config, NULL);
  1794			}
  1795	
  1796			for (u8 i = 0; i < dev->num_svid_inputs; i++) {
  1797				snprintf(dev->ctrl_svid_to_output_names[i],
  1798					 sizeof(dev->ctrl_svid_to_output_names[i]),
> 1799					 "S-Video %03u-%u Is Connected To", dev->inst, i);
  1800			}
  1801	
  1802			for (u8 i = 0; i < dev->num_svid_inputs; i++) {
  1803				struct v4l2_ctrl_config ctrl_config = {
  1804					.ops = &vivid_vid_cap_ctrl_ops,
  1805					.id = VIVID_CID_SVID_IS_CONNECTED_TO_OUTPUT(i),
  1806					.name = dev->ctrl_svid_to_output_names[i],
  1807					.type = V4L2_CTRL_TYPE_MENU,
  1808					.max = 1,
  1809					.qmenu = (const char * const *)vivid_ctrl_svid_to_output_strings,
  1810				};
  1811				dev->ctrl_svid_to_output[i] = v4l2_ctrl_new_custom(hdl_vid_cap,
  1812										   &ctrl_config, NULL);
  1813			}
  1814	
  1815			if (show_ccs_cap) {
  1816				dev->ctrl_has_crop_cap = v4l2_ctrl_new_custom(hdl_vid_cap,
  1817					&vivid_ctrl_has_crop_cap, NULL);
  1818				dev->ctrl_has_compose_cap = v4l2_ctrl_new_custom(hdl_vid_cap,
  1819					&vivid_ctrl_has_compose_cap, NULL);
  1820				dev->ctrl_has_scaler_cap = v4l2_ctrl_new_custom(hdl_vid_cap,
  1821					&vivid_ctrl_has_scaler_cap, NULL);
  1822			}
  1823	
  1824			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_tstamp_src, NULL);
  1825			dev->colorspace = v4l2_ctrl_new_custom(hdl_vid_cap,
  1826				&vivid_ctrl_colorspace, NULL);
  1827			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_xfer_func, NULL);
  1828			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_ycbcr_enc, NULL);
  1829			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_hsv_enc, NULL);
  1830			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_quantization, NULL);
  1831			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_alpha_mode, NULL);
  1832		}
  1833	
  1834		if (dev->has_vid_out && show_ccs_out) {
  1835			dev->ctrl_has_crop_out = v4l2_ctrl_new_custom(hdl_vid_out,
  1836				&vivid_ctrl_has_crop_out, NULL);
  1837			dev->ctrl_has_compose_out = v4l2_ctrl_new_custom(hdl_vid_out,
  1838				&vivid_ctrl_has_compose_out, NULL);
  1839			dev->ctrl_has_scaler_out = v4l2_ctrl_new_custom(hdl_vid_out,
  1840				&vivid_ctrl_has_scaler_out, NULL);
  1841		}
  1842	
  1843		/*
  1844		 * Testing this driver with v4l2-compliance will trigger the error
  1845		 * injection controls, and after that nothing will work as expected.
  1846		 * So we have a module option to drop these error injecting controls
  1847		 * allowing us to run v4l2_compliance again.
  1848		 */
  1849		if (!no_error_inj) {
  1850			v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_disconnect, NULL);
  1851			v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_dqbuf_error, NULL);
  1852			v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_perc_dropped, NULL);
  1853			v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_queue_setup_error, NULL);
  1854			v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_buf_prepare_error, NULL);
  1855			v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_start_streaming_error, NULL);
  1856			v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_queue_error, NULL);
  1857	#ifdef CONFIG_MEDIA_CONTROLLER
  1858			v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_req_validate_error, NULL);
  1859	#endif
  1860			v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_seq_wrap, NULL);
  1861			v4l2_ctrl_new_custom(hdl_streaming, &vivid_ctrl_time_wrap, NULL);
  1862		}
  1863	
  1864		if (has_sdtv && (dev->has_vid_cap || dev->has_vbi_cap)) {
  1865			if (dev->has_vid_cap)
  1866				v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_std_aspect_ratio, NULL);
  1867			dev->ctrl_std_signal_mode = v4l2_ctrl_new_custom(hdl_sdtv_cap,
  1868				&vivid_ctrl_std_signal_mode, NULL);
  1869			dev->ctrl_standard = v4l2_ctrl_new_custom(hdl_sdtv_cap,
  1870				&vivid_ctrl_standard, NULL);
  1871			if (dev->ctrl_std_signal_mode)
  1872				v4l2_ctrl_cluster(2, &dev->ctrl_std_signal_mode);
  1873			if (dev->has_raw_vbi_cap)
  1874				v4l2_ctrl_new_custom(hdl_vbi_cap, &vivid_ctrl_vbi_cap_interlaced, NULL);
  1875		}
  1876	
  1877		if (dev->num_hdmi_inputs) {
  1878			s64 hdmi_input_mask = GENMASK(dev->num_hdmi_inputs - 1, 0);
  1879	
  1880			dev->ctrl_dv_timings_signal_mode = v4l2_ctrl_new_custom(hdl_vid_cap,
  1881						&vivid_ctrl_dv_timings_signal_mode, NULL);
  1882	
  1883			vivid_ctrl_dv_timings.max = dev->query_dv_timings_size - 1;
  1884			vivid_ctrl_dv_timings.qmenu =
  1885				(const char * const *)dev->query_dv_timings_qmenu;
  1886			dev->ctrl_dv_timings = v4l2_ctrl_new_custom(hdl_vid_cap,
  1887				&vivid_ctrl_dv_timings, NULL);
  1888			if (dev->ctrl_dv_timings_signal_mode)
  1889				v4l2_ctrl_cluster(2, &dev->ctrl_dv_timings_signal_mode);
  1890	
  1891			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_dv_timings_aspect_ratio, NULL);
  1892			v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_max_edid_blocks, NULL);
  1893			dev->real_rgb_range_cap = v4l2_ctrl_new_custom(hdl_vid_cap,
  1894				&vivid_ctrl_limited_rgb_range, NULL);
  1895			dev->rgb_range_cap = v4l2_ctrl_new_std_menu(hdl_vid_cap,
  1896				&vivid_vid_cap_ctrl_ops,
  1897				V4L2_CID_DV_RX_RGB_RANGE, V4L2_DV_RGB_RANGE_FULL,
  1898				0, V4L2_DV_RGB_RANGE_AUTO);
  1899			dev->ctrl_rx_power_present = v4l2_ctrl_new_std(hdl_vid_cap,
  1900				NULL, V4L2_CID_DV_RX_POWER_PRESENT, 0, hdmi_input_mask,
  1901				0, hdmi_input_mask);
  1902	
  1903		}
  1904		if (dev->num_hdmi_outputs) {
  1905			s64 hdmi_output_mask = GENMASK(dev->num_hdmi_outputs - 1, 0);
  1906	
  1907			/*
  1908			 * We aren't doing anything with this at the moment, but
  1909			 * HDMI outputs typically have this controls.
  1910			 */
  1911			dev->ctrl_tx_rgb_range = v4l2_ctrl_new_std_menu(hdl_vid_out, NULL,
  1912				V4L2_CID_DV_TX_RGB_RANGE, V4L2_DV_RGB_RANGE_FULL,
  1913				0, V4L2_DV_RGB_RANGE_AUTO);
  1914			dev->ctrl_tx_mode = v4l2_ctrl_new_std_menu(hdl_vid_out, NULL,
  1915				V4L2_CID_DV_TX_MODE, V4L2_DV_TX_MODE_HDMI,
  1916				0, V4L2_DV_TX_MODE_HDMI);
  1917			dev->ctrl_display_present = v4l2_ctrl_new_custom(hdl_vid_out,
  1918				&vivid_ctrl_display_present, NULL);
  1919			dev->ctrl_tx_hotplug = v4l2_ctrl_new_std(hdl_vid_out,
  1920				NULL, V4L2_CID_DV_TX_HOTPLUG, 0, hdmi_output_mask,
  1921				0, hdmi_output_mask);
  1922			dev->ctrl_tx_rxsense = v4l2_ctrl_new_std(hdl_vid_out,
  1923				NULL, V4L2_CID_DV_TX_RXSENSE, 0, hdmi_output_mask,
  1924				0, hdmi_output_mask);
  1925			dev->ctrl_tx_edid_present = v4l2_ctrl_new_std(hdl_vid_out,
  1926				NULL, V4L2_CID_DV_TX_EDID_PRESENT, 0, hdmi_output_mask,
  1927				0, hdmi_output_mask);
  1928		}
  1929		if ((dev->has_vid_cap && dev->has_vid_out) ||
  1930		    (dev->has_vbi_cap && dev->has_vbi_out))
  1931			v4l2_ctrl_new_custom(hdl_loop_cap, &vivid_ctrl_loop_video, NULL);
  1932	
  1933		if (dev->has_fb)
  1934			v4l2_ctrl_new_custom(hdl_fb, &vivid_ctrl_clear_fb, NULL);
  1935	
  1936		if (dev->has_radio_rx) {
  1937			v4l2_ctrl_new_custom(hdl_radio_rx, &vivid_ctrl_radio_hw_seek_mode, NULL);
  1938			v4l2_ctrl_new_custom(hdl_radio_rx, &vivid_ctrl_radio_hw_seek_prog_lim, NULL);
  1939			v4l2_ctrl_new_custom(hdl_radio_rx, &vivid_ctrl_radio_rx_rds_blockio, NULL);
  1940			v4l2_ctrl_new_custom(hdl_radio_rx, &vivid_ctrl_radio_rx_rds_rbds, NULL);
  1941			v4l2_ctrl_new_std(hdl_radio_rx, &vivid_radio_rx_ctrl_ops,
  1942				V4L2_CID_RDS_RECEPTION, 0, 1, 1, 1);
  1943			dev->radio_rx_rds_pty = v4l2_ctrl_new_std(hdl_radio_rx,
  1944				&vivid_radio_rx_ctrl_ops,
  1945				V4L2_CID_RDS_RX_PTY, 0, 31, 1, 0);
  1946			dev->radio_rx_rds_psname = v4l2_ctrl_new_std(hdl_radio_rx,
  1947				&vivid_radio_rx_ctrl_ops,
  1948				V4L2_CID_RDS_RX_PS_NAME, 0, 8, 8, 0);
  1949			dev->radio_rx_rds_radiotext = v4l2_ctrl_new_std(hdl_radio_rx,
  1950				&vivid_radio_rx_ctrl_ops,
  1951				V4L2_CID_RDS_RX_RADIO_TEXT, 0, 64, 64, 0);
  1952			dev->radio_rx_rds_ta = v4l2_ctrl_new_std(hdl_radio_rx,
  1953				&vivid_radio_rx_ctrl_ops,
  1954				V4L2_CID_RDS_RX_TRAFFIC_ANNOUNCEMENT, 0, 1, 1, 0);
  1955			dev->radio_rx_rds_tp = v4l2_ctrl_new_std(hdl_radio_rx,
  1956				&vivid_radio_rx_ctrl_ops,
  1957				V4L2_CID_RDS_RX_TRAFFIC_PROGRAM, 0, 1, 1, 0);
  1958			dev->radio_rx_rds_ms = v4l2_ctrl_new_std(hdl_radio_rx,
  1959				&vivid_radio_rx_ctrl_ops,
  1960				V4L2_CID_RDS_RX_MUSIC_SPEECH, 0, 1, 1, 1);
  1961		}
  1962		if (dev->has_radio_tx) {
  1963			v4l2_ctrl_new_custom(hdl_radio_tx,
  1964				&vivid_ctrl_radio_tx_rds_blockio, NULL);
  1965			dev->radio_tx_rds_pi = v4l2_ctrl_new_std(hdl_radio_tx,
  1966				&vivid_radio_tx_ctrl_ops,
  1967				V4L2_CID_RDS_TX_PI, 0, 0xffff, 1, 0x8088);
  1968			dev->radio_tx_rds_pty = v4l2_ctrl_new_std(hdl_radio_tx,
  1969				&vivid_radio_tx_ctrl_ops,
  1970				V4L2_CID_RDS_TX_PTY, 0, 31, 1, 3);
  1971			dev->radio_tx_rds_psname = v4l2_ctrl_new_std(hdl_radio_tx,
  1972				&vivid_radio_tx_ctrl_ops,
  1973				V4L2_CID_RDS_TX_PS_NAME, 0, 8, 8, 0);
  1974			if (dev->radio_tx_rds_psname)
  1975				v4l2_ctrl_s_ctrl_string(dev->radio_tx_rds_psname, "VIVID-TX");
  1976			dev->radio_tx_rds_radiotext = v4l2_ctrl_new_std(hdl_radio_tx,
  1977				&vivid_radio_tx_ctrl_ops,
  1978				V4L2_CID_RDS_TX_RADIO_TEXT, 0, 64 * 2, 64, 0);
  1979			if (dev->radio_tx_rds_radiotext)
  1980				v4l2_ctrl_s_ctrl_string(dev->radio_tx_rds_radiotext,
  1981				       "This is a VIVID default Radio Text template text, change at will");
  1982			dev->radio_tx_rds_mono_stereo = v4l2_ctrl_new_std(hdl_radio_tx,
  1983				&vivid_radio_tx_ctrl_ops,
  1984				V4L2_CID_RDS_TX_MONO_STEREO, 0, 1, 1, 1);
  1985			dev->radio_tx_rds_art_head = v4l2_ctrl_new_std(hdl_radio_tx,
  1986				&vivid_radio_tx_ctrl_ops,
  1987				V4L2_CID_RDS_TX_ARTIFICIAL_HEAD, 0, 1, 1, 0);
  1988			dev->radio_tx_rds_compressed = v4l2_ctrl_new_std(hdl_radio_tx,
  1989				&vivid_radio_tx_ctrl_ops,
  1990				V4L2_CID_RDS_TX_COMPRESSED, 0, 1, 1, 0);
  1991			dev->radio_tx_rds_dyn_pty = v4l2_ctrl_new_std(hdl_radio_tx,
  1992				&vivid_radio_tx_ctrl_ops,
  1993				V4L2_CID_RDS_TX_DYNAMIC_PTY, 0, 1, 1, 0);
  1994			dev->radio_tx_rds_ta = v4l2_ctrl_new_std(hdl_radio_tx,
  1995				&vivid_radio_tx_ctrl_ops,
  1996				V4L2_CID_RDS_TX_TRAFFIC_ANNOUNCEMENT, 0, 1, 1, 0);
  1997			dev->radio_tx_rds_tp = v4l2_ctrl_new_std(hdl_radio_tx,
  1998				&vivid_radio_tx_ctrl_ops,
  1999				V4L2_CID_RDS_TX_TRAFFIC_PROGRAM, 0, 1, 1, 1);
  2000			dev->radio_tx_rds_ms = v4l2_ctrl_new_std(hdl_radio_tx,
  2001				&vivid_radio_tx_ctrl_ops,
  2002				V4L2_CID_RDS_TX_MUSIC_SPEECH, 0, 1, 1, 1);
  2003		}
  2004		if (dev->has_sdr_cap) {
  2005			v4l2_ctrl_new_custom(hdl_sdr_cap,
  2006				&vivid_ctrl_sdr_cap_fm_deviation, NULL);
  2007		}
  2008		if (dev->has_meta_cap) {
  2009			v4l2_ctrl_new_custom(hdl_meta_cap,
  2010					     &vivid_ctrl_meta_has_pts, NULL);
  2011			v4l2_ctrl_new_custom(hdl_meta_cap,
  2012					     &vivid_ctrl_meta_has_src_clk, NULL);
  2013		}
  2014	
  2015		if (hdl_user_gen->error)
  2016			return hdl_user_gen->error;
  2017		if (hdl_user_vid->error)
  2018			return hdl_user_vid->error;
  2019		if (hdl_user_aud->error)
  2020			return hdl_user_aud->error;
  2021		if (hdl_streaming->error)
  2022			return hdl_streaming->error;
  2023		if (hdl_sdr_cap->error)
  2024			return hdl_sdr_cap->error;
  2025		if (hdl_loop_cap->error)
  2026			return hdl_loop_cap->error;
  2027	
  2028		if (dev->autogain)
  2029			v4l2_ctrl_auto_cluster(2, &dev->autogain, 0, true);
  2030	
  2031		if (dev->has_vid_cap) {
  2032			v4l2_ctrl_add_handler(hdl_vid_cap, hdl_user_gen, NULL, false);
  2033			v4l2_ctrl_add_handler(hdl_vid_cap, hdl_user_vid, NULL, false);
  2034			v4l2_ctrl_add_handler(hdl_vid_cap, hdl_user_aud, NULL, false);
  2035			v4l2_ctrl_add_handler(hdl_vid_cap, hdl_streaming, NULL, false);
  2036			v4l2_ctrl_add_handler(hdl_vid_cap, hdl_sdtv_cap, NULL, false);
  2037			v4l2_ctrl_add_handler(hdl_vid_cap, hdl_loop_cap, NULL, false);
  2038			v4l2_ctrl_add_handler(hdl_vid_cap, hdl_fb, NULL, false);
  2039			if (hdl_vid_cap->error)
  2040				return hdl_vid_cap->error;
  2041			dev->vid_cap_dev.ctrl_handler = hdl_vid_cap;
  2042		}
  2043		if (dev->has_vid_out) {
  2044			v4l2_ctrl_add_handler(hdl_vid_out, hdl_user_gen, NULL, false);
  2045			v4l2_ctrl_add_handler(hdl_vid_out, hdl_user_aud, NULL, false);
  2046			v4l2_ctrl_add_handler(hdl_vid_out, hdl_streaming, NULL, false);
  2047			v4l2_ctrl_add_handler(hdl_vid_out, hdl_fb, NULL, false);
  2048			if (hdl_vid_out->error)
  2049				return hdl_vid_out->error;
  2050			dev->vid_out_dev.ctrl_handler = hdl_vid_out;
  2051		}
  2052		if (dev->has_vbi_cap) {
  2053			v4l2_ctrl_add_handler(hdl_vbi_cap, hdl_user_gen, NULL, false);
  2054			v4l2_ctrl_add_handler(hdl_vbi_cap, hdl_streaming, NULL, false);
  2055			v4l2_ctrl_add_handler(hdl_vbi_cap, hdl_sdtv_cap, NULL, false);
  2056			v4l2_ctrl_add_handler(hdl_vbi_cap, hdl_loop_cap, NULL, false);
  2057			if (hdl_vbi_cap->error)
  2058				return hdl_vbi_cap->error;
  2059			dev->vbi_cap_dev.ctrl_handler = hdl_vbi_cap;
  2060		}
  2061		if (dev->has_vbi_out) {
  2062			v4l2_ctrl_add_handler(hdl_vbi_out, hdl_user_gen, NULL, false);
  2063			v4l2_ctrl_add_handler(hdl_vbi_out, hdl_streaming, NULL, false);
  2064			if (hdl_vbi_out->error)
  2065				return hdl_vbi_out->error;
  2066			dev->vbi_out_dev.ctrl_handler = hdl_vbi_out;
  2067		}
  2068		if (dev->has_radio_rx) {
  2069			v4l2_ctrl_add_handler(hdl_radio_rx, hdl_user_gen, NULL, false);
  2070			v4l2_ctrl_add_handler(hdl_radio_rx, hdl_user_aud, NULL, false);
  2071			if (hdl_radio_rx->error)
  2072				return hdl_radio_rx->error;
  2073			dev->radio_rx_dev.ctrl_handler = hdl_radio_rx;
  2074		}
  2075		if (dev->has_radio_tx) {
  2076			v4l2_ctrl_add_handler(hdl_radio_tx, hdl_user_gen, NULL, false);
  2077			v4l2_ctrl_add_handler(hdl_radio_tx, hdl_user_aud, NULL, false);
  2078			if (hdl_radio_tx->error)
  2079				return hdl_radio_tx->error;
  2080			dev->radio_tx_dev.ctrl_handler = hdl_radio_tx;
  2081		}
  2082		if (dev->has_sdr_cap) {
  2083			v4l2_ctrl_add_handler(hdl_sdr_cap, hdl_user_gen, NULL, false);
  2084			v4l2_ctrl_add_handler(hdl_sdr_cap, hdl_streaming, NULL, false);
  2085			if (hdl_sdr_cap->error)
  2086				return hdl_sdr_cap->error;
  2087			dev->sdr_cap_dev.ctrl_handler = hdl_sdr_cap;
  2088		}
  2089		if (dev->has_meta_cap) {
  2090			v4l2_ctrl_add_handler(hdl_meta_cap, hdl_user_gen, NULL, false);
  2091			v4l2_ctrl_add_handler(hdl_meta_cap, hdl_streaming, NULL, false);
  2092			if (hdl_meta_cap->error)
  2093				return hdl_meta_cap->error;
  2094			dev->meta_cap_dev.ctrl_handler = hdl_meta_cap;
  2095		}
  2096		if (dev->has_meta_out) {
  2097			v4l2_ctrl_add_handler(hdl_meta_out, hdl_user_gen, NULL, false);
  2098			v4l2_ctrl_add_handler(hdl_meta_out, hdl_streaming, NULL, false);
  2099			if (hdl_meta_out->error)
  2100				return hdl_meta_out->error;
  2101			dev->meta_out_dev.ctrl_handler = hdl_meta_out;
  2102		}
  2103		if (dev->has_touch_cap) {
  2104			v4l2_ctrl_add_handler(hdl_tch_cap, hdl_user_gen, NULL, false);
  2105			v4l2_ctrl_add_handler(hdl_tch_cap, hdl_streaming, NULL, false);
  2106			if (hdl_tch_cap->error)
  2107				return hdl_tch_cap->error;
  2108			dev->touch_cap_dev.ctrl_handler = hdl_tch_cap;
  2109		}
  2110		return 0;
  2111	}
  2112	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

